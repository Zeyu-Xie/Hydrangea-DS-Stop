//
//  selectFolderPath.swift
//  DS Stop
//
//  Created by Zeyu Xie on 2024-12-19.
//

import AppKit

func selectFolderPath() -> (String, String) {
    let openPanel = NSOpenPanel()
    openPanel.title = "Select Folder"
    openPanel.canChooseFiles = false
    openPanel.canChooseDirectories = true
    openPanel.allowsMultipleSelection = false
    if openPanel.runModal() == .OK, let selectedURL = openPanel.url {
        return ("Success", selectedURL.path)
    }
    return ("Error: Failed to select a folder path.", "")
}
