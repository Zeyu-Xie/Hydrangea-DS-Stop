import Foundation

func extractFile(directory: String, fileNames: [String]) -> Array<String> {
    let fileManager = FileManager.default
    let directoryURL = URL(fileURLWithPath: directory)
    guard let enumerator = fileManager.enumerator(at: directoryURL, includingPropertiesForKeys: nil) else {
        return []
    }
    var output: Array<String> = []
    for case let fileURL as URL in enumerator {
        if fileNames.contains(fileURL.lastPathComponent) {
            output.append(fileURL.path)
        }
    }
    return output
}
