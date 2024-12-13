from ds_store import DSStore
import sys
if __name__ == "__main__":
    ds_store_file_path = sys.argv[1]
    fileName_list = set()
    code_list = set()
    ds_store_dict = {}
    with DSStore.open(ds_store_file_path, mode='r') as ds_store:
        for entry in ds_store:
            fileName = entry.filename
            code = entry.code.decode('utf-8')
            value = entry.value
            fileName_list.add(fileName)
            code_list.add(code)
            if fileName not in ds_store_dict:
                ds_store_dict[fileName] = {}
            ds_store_dict[fileName][code] = {
                "type": type(value).__name__,
                "value": str(value)
            }
    for fileName in ds_store_dict:
        for code in code_list:
            if code not in ds_store_dict[fileName]:
                ds_store_dict[fileName][code] = {
                    "type": "None",
                    "value": "None"
                }
    output = {
        "fileName_list": list(fileName_list),
        "code_list": list(code_list),
        "ds_store_dict": ds_store_dict
    }
    print(output)