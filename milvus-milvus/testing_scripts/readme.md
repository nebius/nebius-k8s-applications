# smoke-test.py
1. Install Milvus into cluster
2. Port forward "standalone" for Standalone mode and "milvus-proxy" for Cluster mode with the same port.
3. run smoke-test.py to check if milvus is accessible and responds to basic operations

# hello_milvus.py
1. Install Milvus into cluster
2. Port forward "standalone" for Standalone mode and "milvus-proxy" for Cluster mode with the same port.
3. Run hello_milvus.py to check if milvus is accessible and responds to basic operations
4. Comment last block in the script (deleting created collections) and run it again
5. Install `pip3 install milvus-cli`
6. Run `milvus_cli` and run following commands:
    - `connect`
    - `list connections`
    - `show collection hello_milvus`
