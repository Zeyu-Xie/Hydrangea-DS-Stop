import Foundation

func _extractFile(rootPath: String, fileNames: Array<String>) -> Array<String> {
    if !isDir(path: rootPath) {
        return []
    }
    let fileManager = FileManager.default
    let directoryURL = URL(fileURLWithPath: rootPath)
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
