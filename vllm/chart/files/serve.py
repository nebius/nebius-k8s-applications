import os

from typing import Dict, Optional, List
import logging

from fastapi import FastAPI
from starlette.requests import Request
from starlette.responses import StreamingResponse, JSONResponse

from ray import serve

from vllm.engine.arg_utils import AsyncEngineArgs
from vllm.engine.async_llm_engine import AsyncLLMEngine
from vllm.entrypoints.openai.cli_args import make_arg_parser
from vllm.entrypoints.openai.protocol import (
    ChatCompletionRequest,
    ChatCompletionResponse,
    ErrorResponse,
)
from vllm.entrypoints.openai.serving_chat import OpenAIServingChat
from vllm.utils import FlexibleArgumentParser
from vllm.entrypoints.openai.serving_models import (BaseModelPath,
                                                    OpenAIServingModels)

import yaml

logger = logging.getLogger("ray.serve")

app = FastAPI()

vllm_config = dict()
with open(os.environ['VLLM_CONFIG']) as file:
    vllm_config = yaml.safe_load(file)

@serve.deployment(
    name="VLLMDeployment",
    ray_actor_options = {
        "num_cpus": int(os.environ.get("VLLM_RAY_NUM_CPUS", 14)) * int(vllm_config["tensor-parallel-size"]),
        "memory": int(os.environ.get("VLLM_RAY_MEMORY", 1024 * 1024 * 1024)) * int(vllm_config["tensor-parallel-size"]),
    }
)
@serve.ingress(app)
class VLLMDeployment:
    def __init__(
        self,
        engine_args: AsyncEngineArgs,
        response_role: str,
        chat_template: Optional[str] = None,
    ):
        logger.info(f"Starting with engine args: {engine_args}")
        # Fix required if not all gpu available for ray
        if os.environ['CUDA_VISIBLE_DEVICES'] == '':
            del os.environ['CUDA_VISIBLE_DEVICES']
        # os.environ['CUDA_VISIBLE_DEVICES'] = '0,1,2,3,4,5,6,7'
        logger.info(os.environ)
        self.openai_serving_chat = None
        self.engine_args = engine_args
        self.response_role = response_role
        self.chat_template = chat_template
        self.engine = AsyncLLMEngine.from_engine_args(engine_args)

    # TODO: implement dynamic reconfiguration
    # def reconfigure(self, config: Dict[str, Any]):
    #     self.threshold = config["threshold"]

    @app.post("/v1/chat/completions")
    async def create_chat_completion(
        self, request: ChatCompletionRequest, raw_request: Request
    ):
        """OpenAI-compatible HTTP endpoint.

        API reference:
            - https://docs.vllm.ai/en/latest/serving/openai_compatible_server.html
        """
        if not self.openai_serving_chat:
            model_config = await self.engine.get_model_config()
            # Determine the name of the served model for the OpenAI client.
            if self.engine_args.served_model_name is not None:
                served_model_names = self.engine_args.served_model_name
            else:
                served_model_names = [self.engine_args.model]

            base_model_paths = [
                BaseModelPath(name=name, model_path=self.engine_args.model)
                for name in served_model_names
            ]

            openai_serving_models = OpenAIServingModels(
                engine_client=self.engine,
                model_config=model_config,
                base_model_paths=base_model_paths,
                lora_modules=None,
                prompt_adapters=None,
            )

            self.openai_serving_chat = OpenAIServingChat(
                self.engine,
                model_config,
                openai_serving_models,
                self.response_role,
                chat_template=self.chat_template,
                chat_template_content_format="auto",
                request_logger=None,
            )
        logger.info(f"Request: {request}")
        generator = await self.openai_serving_chat.create_chat_completion(
            request, raw_request
        )
        if isinstance(generator, ErrorResponse):
            return JSONResponse(
                content=generator.model_dump(), status_code=generator.code
            )
        if request.stream:
            return StreamingResponse(content=generator, media_type="text/event-stream")
        else:
            assert isinstance(generator, ChatCompletionResponse)
            return JSONResponse(content=generator.model_dump())


def parse_vllm_args(cli_args: Dict[str, str]):
    """Parses vLLM args based on CLI inputs.

    Currently uses argparse because vLLM doesn't expose Python models for all of the
    config options we want to support.
    """
    parser = FlexibleArgumentParser(description="vLLM CLI")
    parser = make_arg_parser(parser)
    arg_strings = []
    for key, value in cli_args.items():
        if value is not None:
            arg_strings.extend([f"--{key}", str(value)])
        else:
            arg_strings.extend([f"--{key}"])
    logger.info(arg_strings)
    parsed_args = parser.parse_args(args=arg_strings)
    return parsed_args


def build_app(cli_args: Dict[str, str]) -> serve.Application:
    """Builds the Serve app based on CLI arguments.

    See https://docs.vllm.ai/en/latest/serving/openai_compatible_server.html#command-line-arguments-for-the-server
    for the complete set of arguments.

    Supported engine arguments: https://docs.vllm.ai/en/latest/models/engine_args.html.
    """  # noqa: E501
    parsed_args = parse_vllm_args(cli_args)
    engine_args = AsyncEngineArgs.from_cli_args(parsed_args)
    engine_args.worker_use_ray = True

    return VLLMDeployment.bind(
        engine_args,
        parsed_args.response_role,
        parsed_args.chat_template,
    )

model = build_app(vllm_config)
