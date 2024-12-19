//
//  deleteDSStore.swift
//  DS Stop
//
//  Created by Zeyu Xie on 2024-12-19.
//

import Foundation

func delete_DSStore(folderPath: String?) -> (String, Array<String>) {
    if folderPath == nil {
        return ("Error: The folder path is nil.", [])
    }
    if !isDir(path: folderPath!) {
        return ("Error: The path does not correspond to a folder.", [])
    }
    let fileManager = FileManager.default
    let directoryURL = URL(fileURLWithPath: folderPath!)
    guard let enumerator = fileManager.enumerator(at: directoryURL, includingPropertiesForKeys: nil) else {
        return ("Error: Failed to generate an enumerator.", [])
    }
    var deletedFileList: Array<String> = []
    for case let fileURL as URL in enumerator {
        if fileURL.lastPathComponent == ".DS_Store" {
            do {
                if fileURL.hasDirectoryPath {
                    continue
                }
                try fileManager.removeItem(at: fileURL)
                print("Deleted .DS_Store file at \(fileURL)")
                deletedFileList.append(fileURL.path)
            } catch {
                return ("Erorr: Failed to delete file at \(fileURL)", [])
            }
        }
    }
    return ("Success", deletedFileList)
}
