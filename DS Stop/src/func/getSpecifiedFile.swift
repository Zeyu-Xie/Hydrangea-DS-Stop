//
//  getSpecifiedFile.swift
//  DS Stop
//
//  Created by Zeyu Xie on 2024-12-09.
//

import Foundation

func getSpecifiedFile(fromDirectory: String, targetFile: String) -> Array<String> {

    let expandedPath = (fromDirectory as NSString).expandingTildeInPath
    let folderURL = URL(fileURLWithPath: expandedPath).standardized
    
    if let enumerator = FileManager.default.enumerator(
        at: folderURL,
        includingPropertiesForKeys: nil
    ) {
        var output : Array<String> = []
        for case let fileURL as URL in enumerator {
            if fileURL.lastPathComponent == targetFile {
                output.append(fileURL.path)
            }
        }
        return output
    }
    
    return []
}
