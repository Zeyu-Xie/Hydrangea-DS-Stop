import AppKit

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
