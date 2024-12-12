import Foundation
import UniformTypeIdentifiers
import AppKit

// Write a file with Save Panel
func writeFile(
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
