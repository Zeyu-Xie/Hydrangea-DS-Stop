import Foundation

// If the path represents a folder
func isDir(path: String) -> Bool {
    var isDirectory: ObjCBool = false
    return FileManager.default
        .fileExists(atPath: path, isDirectory: &isDirectory) && isDirectory.boolValue
}
