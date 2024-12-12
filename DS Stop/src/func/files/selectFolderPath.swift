import AppKit

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
