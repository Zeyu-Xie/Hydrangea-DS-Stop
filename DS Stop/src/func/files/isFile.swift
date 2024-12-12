import Foundation

func isFile(path: String?) -> Bool {
    if path == nil {
        return false
    }
    var isDirectory: ObjCBool = false
    return FileManager.default
        .fileExists(
            atPath: path!,
            isDirectory: &isDirectory
        ) && !isDirectory.boolValue
}
