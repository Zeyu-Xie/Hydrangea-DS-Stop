from ds_store import DSStore
import os
import sys
import json

# The path of the selected .DS_Store file
ds_store_file_path = sys.argv[1]

data = {}
keys = []

if __name__ == '__main__':
    if not os.path.exists(ds_store_file_path):
        print("The path does not exist")
        sys.exit(1)
    if not os.path.isfile(ds_store_file_path):
        print("The path is not a file")
        sys.exit(1)
    if os.path.basename(ds_store_file_path) != '.DS_Store':
        print("Filename is not .DS_Store")
        sys.exit(1)

    with DSStore.open(ds_store_file_path) as ds:
        for item in ds:
            if not item.filename in data:
                data[item.filename] = {}
            if not item.code.decode("utf-8") in keys:
                keys.append(item.code.decode("utf-8"))
            data[item.filename][item.code.decode("utf-8")] = item.value
    
    for fileName in data.keys():
        for key in keys:
            if not key in data[fileName]:
                data[fileName][key] = None

    print(json.dumps(data, indent=4, ensure_ascii=False))