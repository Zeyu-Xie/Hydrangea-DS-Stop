//
//  _treeEncoder.swift
//  DS Stop
//
//  Created by Zeyu Xie on 2024-12-19.
//

import Foundation

func _treeEncodor(files: Array<String>, folderPath: String?) -> (
    String,
    [String: Data]
) {
    if folderPath == nil {
        return ("Error: The folder path is nil.", [:])
    }
    if !isDir(path: folderPath!) {
        return ("Error: The path does not correspond to a file.", [:])
    }
    var output: [String: Data] = [:]
    for file in files {
        var isDirectory: ObjCBool = false
        if FileManager.default
            .fileExists(atPath: file, isDirectory: &isDirectory), !isDirectory.boolValue {
            let url = URL(fileURLWithPath: file)
            do {
                let fileContent = try Data(contentsOf: url)
                let relativePath = url.path.replacingOccurrences(
                    of: folderPath!,
                    with: ""
                )
                output[relativePath] = fileContent
            } catch {
                return ("Error: Failed to read file at \(file)", [:])
            }
        }
    }
    return ("Success", output)
}
