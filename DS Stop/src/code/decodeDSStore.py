#
# decodeDSStore.py
# DS Stop
#
# Created by Zeyu Xie on 2024-12-19.
#

import sys
import csv
from ds_store import DSStore


def processValue(value):
    allowed_type_list = [int, float, str, bool, type(None), list, dict, tuple, set]
    if type(value) in allowed_type_list:
        return value
    return str(value)


if __name__ == "__main__":
    ds_store_file_path = sys.argv[1]
    fileName_list = set()
    code_list = set()
    ds_store_dict = {}

    with DSStore.open(ds_store_file_path, mode="r") as ds_store:
        for entry in ds_store:
            fileName = entry.filename
            code = entry.code.decode("utf-8")
            value = entry.value
            fileName_list.add(fileName)
            code_list.add(code)
            if fileName not in ds_store_dict:
                ds_store_dict[fileName] = {}
            ds_store_dict[fileName][code] = processValue(value)

    for fileName in ds_store_dict:
        for code in code_list:
            if code not in ds_store_dict[fileName]:
                ds_store_dict[fileName][code] = None

    file_list = sorted(fileName_list)
    code_list = sorted(code_list)

    csv_output = []
    headers = ["fileName"] + code_list
    csv_output.append(headers)

    for fileName in file_list:
        row = [fileName]
        for code in code_list:
            value = ds_store_dict[fileName].get(code, None)
            row.append(str(value) if value is not None else "")
        csv_output.append(row)

    csv_string = ""
    writer = csv.writer(sys.stdout, lineterminator="\n")
    for row in csv_output:
        writer.writerow(row)
