import AppKit
import Foundation
import UniformTypeIdentifiers

// Write certain content to a file and export it
func exportFile(
    content: Data,
    defaultFileName: String,
    allowedType: Array<UTType>,
    title: String = "Export File"
) {
    let panel = NSSavePanel()
    panel.title = title
    panel.allowedContentTypes = allowedType
    panel.nameFieldStringValue = defaultFileName
    panel.begin { response in
        if response == .OK, let url = panel.url {
            do {
                try content.write(to: url)
                print("File saved at \(url)")
            } catch {
                print("Failed to save file: \(error.localizedDescription)")
            }
        } else {
            print("User cancelled the operation")
        }
    }
}


// Select a file, and return its path
func selectFilePath() -> String? {
    let openPanel = NSOpenPanel()
    openPanel.title = "Select File"
    openPanel.canChooseFiles = true
    openPanel.canChooseDirectories = false
    openPanel.allowsMultipleSelection = false
    if openPanel.runModal() == .OK, let selectedURL = openPanel.url {
        return selectedURL.path
    }
    return nil
}

// Select a folder, and return its path
func selectFolderPath() -> String? {
    let openPanel = NSOpenPanel()
    openPanel.title = "Select Folder"
    openPanel.canChooseFiles = false
    openPanel.canChooseDirectories = true
    openPanel.allowsMultipleSelection = false
    if openPanel.runModal() == .OK, let selectedURL = openPanel.url {
        return selectedURL.path
    }
    return nil
}
