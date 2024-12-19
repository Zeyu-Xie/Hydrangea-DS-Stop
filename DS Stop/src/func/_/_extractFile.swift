//
//  _extractFile.swift
//  DS Stop
//
//  Created by Zeyu Xie on 2024-12-19.
//

import Foundation

func _extractFile(folderPath: String?, fileNames: Array<String>) -> (
    String,
    Array<String>
) {
    if folderPath == nil {
        return ("Error: The folder path is nil.", [])
    }
    if !isDir(path: folderPath!) {
        return ("Error: The path does not correspond to a file.", [])
    }
    let fileManager = FileManager.default
    let directoryURL = URL(fileURLWithPath: folderPath!)
    guard let enumerator = fileManager.enumerator(at: directoryURL, includingPropertiesForKeys: nil) else {
        return ("Error: Failed to generate an enumerator.", [])
    }
    var output: Array<String> = []
    for case let fileURL as URL in enumerator {
        if fileNames.contains(fileURL.lastPathComponent) {
            output.append(fileURL.path)
        }
    }
    return ("Success", output)
}
