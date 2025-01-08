from pymilvus import connections, FieldSchema, CollectionSchema, DataType, Collection, utility
import random

# 1. Connect to Milvus
def connect_to_milvus():
    connections.connect("default", host="localhost", port="19530")
    print("✅ Connected to Milvus")

# 2. Create Collection Schema
def create_collection():
    fields = [
        FieldSchema(name="id", dtype=DataType.INT64, is_primary=True),
        FieldSchema(name="vector", dtype=DataType.FLOAT_VECTOR, dim=128)
    ]
    schema = CollectionSchema(fields, "example collection")
    collection = Collection(name="example", schema=schema)
    print(f"✅ Collection '{collection.name}' created")
    return collection

# 3. Create Index
def create_index(collection):
    index_params = {
        "index_type": "IVF_FLAT",
        "metric_type": "L2",
        "params": {"nlist": 128}
    }
    collection.create_index(field_name="vector", index_params=index_params)
    print("✅ Index created for collection")

# 4. Insert Data
def insert_data(collection):
    data = [
        [i for i in range(10)],  # IDs
        [[random.random() for _ in range(128)] for _ in range(10)]  # Random vectors
    ]
    collection.insert(data)
    collection.load()
    print(f"✅ Inserted {len(data[0])} rows into '{collection.name}'")

# 5. Perform Search
def search_data(collection):
    search_vectors = [[random.random() for _ in range(128)]]
    search_params = {"metric_type": "L2", "params": {"nprobe": 10}}  # Add nprobe to param

    res = collection.search(
        search_vectors,
        "vector",
        param=search_params,  # Fixed: Added param argument
        limit=5,
        expr=None
    )
    print("✅ Searched Collection")

# Main Function
if __name__ == "__main__":
    connect_to_milvus()

    # If the collection already exists, drop and recreate
    if utility.has_collection("example"):
        Collection("example").drop()
        print("⚠️ Existing collection dropped")

    collection = create_collection()
    create_index(collection)
    insert_data(collection)
    search_data(collection)
