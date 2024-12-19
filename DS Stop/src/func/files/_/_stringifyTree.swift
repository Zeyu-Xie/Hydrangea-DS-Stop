//
//  stringifyTree.swift
//  DS Stop
//
//  Created by Zeyu Xie on 2024-12-19.
//

import Foundation

func _stringifyTree(tree: Dictionary<String, Any>, indent: Int = 0) -> (
    String,
    String
) {
    var output = ""
    var status = ""
    let sortedTree = tree.sorted { $0.key < $1.key }
    for (key, value) in sortedTree {
        if value is String {
            output += String(repeating: " ", count: indent) + "  " + key + "\n"
        } else if value is Dictionary<String, Any> {
            output += String(repeating: " ", count: indent) + "- " + key + "\n"
            var _tmp = ""
            (status, _tmp) = _stringifyTree(
                tree: value as! Dictionary<String,
                Any>,
                indent: indent + 2
            )
            if status != "Success" {
                return (status, "")
            }
            output += _tmp
        }
    }
    return ("Success", output)
}
