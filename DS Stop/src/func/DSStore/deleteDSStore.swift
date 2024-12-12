import Foundation

// Recursively delete .DS_Store
// Return the lists of paths of successfully deleted files and failed ones.
func delete_DSStore(folderPath: String) -> (Array<String>, Array<String>) {
    if !isDir(path: folderPath) {
        return ([], [])
    }
    let fileManager = FileManager.default
    let directoryURL = URL(fileURLWithPath: folderPath)
    guard let enumerator = fileManager.enumerator(at: directoryURL, includingPropertiesForKeys: nil) else {
        return ([], [])
    }
    var succList: Array<String> = []
    var failList: Array<String> = []
    for case let fileURL as URL in enumerator {
        if fileURL.lastPathComponent == ".DS_Store" {
            do {
                if fileURL.hasDirectoryPath {
                    continue
                }
                try fileManager.removeItem(at: fileURL)
                print("Deleted .DS_Store file at \(fileURL)")
                succList.append(fileURL.path)
            } catch {
                print("Failed to delete file at \(fileURL): \(error)")
                failList.append(fileURL.path)
            }
        }
    }
    return (succList, failList)
}
