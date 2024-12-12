import Foundation
import SwiftUI

// Import the binary file to recover .DS_Store
// Return the lists of paths of the changed .DS_Store files
func import_DSStore(folderPath: String) -> Array<String> {
    if !isDir(path: folderPath) {
        return []
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
        print("User cancelled the operation")
        return []
    }
    let url = URL(fileURLWithPath: binPath)
    do {
        let data = try Data(contentsOf: url)
        let decodedFile = try JSONDecoder().decode(
            [String: Data].self,
            from: data
        )
        for (relativePath, fileContent) in decodedFile {
            let filePath = folderPath + relativePath
            let fileURL = URL(fileURLWithPath: filePath)
            do {
                try fileContent.write(to: fileURL)
                print("File saved at \(fileURL)")
            } catch {
                print("Failed to save file at \(fileURL): \(error)")
            }
        }
        return Array(decodedFile.keys).map { folderPath + $0 }
    } catch {
        print("Failed to decode JSON: \(error)")
        return []
    }
}

