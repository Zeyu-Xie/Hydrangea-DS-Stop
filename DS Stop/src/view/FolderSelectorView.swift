import SwiftUI

struct FolderSelectorView: View {
    @Binding var folderPath: String?
    var body: some View {
        VStack {
            Button(action: selectFile) {
                Text("Select Folder")
            }
        }
        .padding()
    }
    private func selectFile() {
        let openPanel = NSOpenPanel()
        openPanel.title = "Select Folder"
        openPanel.canChooseFiles = false
        openPanel.canChooseDirectories = true
        openPanel.allowsMultipleSelection = false
        if openPanel.runModal() == .OK, let selectedURL = openPanel.url {
            folderPath = selectedURL.path
        }
    }
}
