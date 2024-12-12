import Foundation

// Encode the extracted files to a single binary file
func _treeEncodor(files: Array<String>, rootPath: String) -> [String: Data] {
    if !isDir(path: rootPath) {
        return [:]
    }
    var output: [String: Data] = [:]
    for file in files {
        var isDirectory: ObjCBool = false
        if FileManager.default
            .fileExists(atPath: file, isDirectory: &isDirectory), !isDirectory.boolValue {
            let url = URL(fileURLWithPath: file)
            do {
                let fileContent = try Data(contentsOf: url)
                let relativePath = url.path.replacingOccurrences(
                    of: rootPath,
                    with: ""
                )
                output[relativePath] = fileContent
            } catch {
                print("Failed to read file at \(file): \(error)")
            }
        }
    }
    return output
}
