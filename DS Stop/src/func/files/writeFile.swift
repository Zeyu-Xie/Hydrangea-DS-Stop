//
//  writeFile.swift
//  DS Stop
//
//  Created by Zeyu Xie on 2024-12-19.
//
import Foundation
import UniformTypeIdentifiers
import AppKit

func writeFile(
    content: Data,
    filePath: String?,
    allowedType: Array<UTType>,
    title: String = "Export File"
) -> String {
    
    if filePath == nil {
        return "Error: The file path is nil."
    }
    
    let panel = NSSavePanel()
    var status = ""
    panel.title = title
    panel.allowedContentTypes = allowedType
    panel.nameFieldStringValue = filePath!
    panel.begin { response in
        if response == .OK, let url = panel.url {
            do {
                try content.write(to: url)
                status = "Success"
            } catch {
                status = "Error: Failed to save the file."
            }
        } else {
            status =  "Error: User canceled the operation."
        }
    }
    return status
}
