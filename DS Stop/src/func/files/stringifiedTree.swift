//
//  stringifiedTree.swift
//  DS Stop
//
//  Created by Zeyu Xie on 2024-12-19.
//

import Foundation

func StringifiedTree(path: String?) -> (String, String) {
    if path == nil {
        return ("Error: The path is nil.", "")
    }
    let (status_1, tree) = _listTree(path: path!)
    if status_1 != "Success" {
        return (status_1, "")
    }
    let (status_2, output) = _stringifyTree(tree: tree)
    if status_2 != "Success" {
        return (status_2, "")
    }
    return ("Success", output)
}
