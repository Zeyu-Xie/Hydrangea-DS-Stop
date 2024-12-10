import Foundation

// Delete all .git folders
func func_delete_Git(folderPath: String) {
    let fileManager = FileManager.default
    let directoryURL = URL(fileURLWithPath: folderPath)
    guard let enumerator = fileManager.enumerator(at: directoryURL, includingPropertiesForKeys: nil) else {
        return
    }
    for case let fileURL as URL in enumerator {
        if fileURL.lastPathComponent == ".git" {
            do {
                if !fileURL.hasDirectoryPath {
                    continue
                }
                try fileManager.removeItem(at: fileURL)
                print("Deleted .git folder at \(fileURL)")
            } catch {
                print("Failed to delete folder at \(fileURL): \(error)")
            }
        }
    }
}
