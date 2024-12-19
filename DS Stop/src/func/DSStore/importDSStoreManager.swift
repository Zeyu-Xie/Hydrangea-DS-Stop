//
//  importDSStoreManager.swift
//  DS Stop
//
//  Created by Zeyu Xie on 2024-12-19.
//

import Foundation
import SwiftUI

func import_DSStore(folderPath: String?) -> (String, Array<String>) {
    
    if folderPath == nil {
        return ("Error: The folder path is nil.", [])
    }
    
    if !isDir(path: folderPath!) {
        return ("Error: The path does not correspond to a folder.", [])
    }
    
    var binPath: String = ""
    let openPanel = NSOpenPanel()
    openPanel.title = "Select Binary File"
    openPanel.canChooseFiles = true
    openPanel.canChooseDirectories = false
    openPanel.allowsMultipleSelection = false
    if openPanel.runModal() == .OK, let selectedURL = openPanel.url {
        binPath = selectedURL.path
    }
    else {
        return ("Error: User canceled the operation", [])
    }
    let url = URL(fileURLWithPath: binPath)
    do {
        let data = try Data(contentsOf: url)
        let decodedFile = try JSONDecoder().decode(
            [String: Data].self,
            from: data
        )
        for (relativePath, fileContent) in decodedFile {
            let filePath = folderPath! + relativePath
            let fileURL = URL(fileURLWithPath: filePath)
            do {
                try fileContent.write(to: fileURL)
            } catch {
                return ("Error: Failed to save file at \(fileURL).", [])
            }
        }
        let output = Array(decodedFile.keys).map { folderPath! + $0 }
        return ("Success", output)
    } catch {
        return ("Error: Failed to decode the JSON file.", [])
    }
}
