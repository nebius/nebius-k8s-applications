#!/bin/bash

# Define an array of Docker images
declare -a images=(
    nvidia/cuda:12.2.2-base-ubuntu20.04
    alpine:3.19
)

docker login   --username iam   --password $(ncp iam create-token)   cr.ai.nebius.cloud

# Loop through the array to tag and push the images
for image in "${images[@]}"
do
    docker pull --platform linux/amd64 "$image"
   
    new_registry="cr.ai.nebius.cloud/crng6buqs6ev01fc6sff/nebius/stable-diffusion-webui"
    image_name="$(echo "$image" | awk -F'/' '{print $NF}')"
    tag_name="$(echo "$image_name" | awk -F':' '{print $NF}')"
    image_name_without_tag="$(echo "$image_name" | awk -F':' '{print $1}')"
    docker tag "$image" "$new_registry/$image_name_without_tag:$tag_name"
    echo "$new_registry/$image_name_without_tag:$tag_name"
    docker push "$new_registry/$image_name_without_tag:$tag_name"
done
