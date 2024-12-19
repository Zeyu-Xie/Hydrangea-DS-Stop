//
//  isFile.swift
//  DS Stop
//
//  Created by Zeyu Xie on 2024-12-19.
//

import Foundation

func isFile(path: String?) -> Bool {
    if path == nil {
        return false
    }
    var isDirectory: ObjCBool = false
    return FileManager.default
        .fileExists(
            atPath: path!,
            isDirectory: &isDirectory
        ) && !isDirectory.boolValue
}
