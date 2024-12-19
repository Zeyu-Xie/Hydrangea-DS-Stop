//
//  selectFilePath.swift
//  DS Stop
//
//  Created by Zeyu Xie on 2024-12-19.
//

import AppKit

func selectFilePath() -> (String, String) {
    let openPanel = NSOpenPanel()
    openPanel.title = "Select File"
    openPanel.canChooseFiles = true
    openPanel.canChooseDirectories = false
    openPanel.allowsMultipleSelection = false
    if openPanel.runModal() == .OK, let selectedURL = openPanel.url {
        return ("Success", selectedURL.path)
    }
    return ("Error: Failed to select a file path.", "")
}
