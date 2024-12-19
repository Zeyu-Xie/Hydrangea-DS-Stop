//
//  _listTree.swift
//  DS Stop
//
//  Created by Zeyu Xie on 2024-12-19.
//

import Foundation

func _listTree(path: String?) -> (String, Dictionary<String, Any>) {
    
    if path == nil {
        return ("Error: The path is nil.", [:])
    }
    
    var output: Dictionary<String, Any> = [:]
    let fileManager = FileManager.default
    let directoryURL = URL(fileURLWithPath: path!)
    
    do {
        let items = try fileManager.contentsOfDirectory(atPath: path!)
        for item in items {
            let fullPath = directoryURL.appendingPathComponent(item).path
            if isDir(path: fullPath) {
                output[item] = _listTree(path: fullPath)
            } else {
                output[item] = "File"
            }
        }
    } catch {
        return ("Error: Failed to read the directory \(directoryURL).", [:])
    }
    return ("Success", output)
}
