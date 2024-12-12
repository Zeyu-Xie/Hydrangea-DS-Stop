import Foundation

// If the path represents a file
func isFile(path: String) -> Bool {
    var isDirectory: ObjCBool = false
    return FileManager.default
        .fileExists(
            atPath: path,
            isDirectory: &isDirectory
        ) && !isDirectory.boolValue
}
