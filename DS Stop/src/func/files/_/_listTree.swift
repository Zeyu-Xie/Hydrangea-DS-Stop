import Foundation

func _listTree(path: String) -> Dictionary<String, Any> {
    var output: Dictionary<String, Any> = [:]
    let fileManager = FileManager.default
    let directoryURL = URL(fileURLWithPath: path)
    
    do {
        let items = try fileManager.contentsOfDirectory(atPath: path)
        for item in items {
            let fullPath = directoryURL.appendingPathComponent(item).path
            if isDir(path: fullPath) {
                output[item] = _listTree(path: fullPath)
            } else {
                output[item] = "File" // 如果是文件，标记为文件
            }
        }
    } catch {
        print("Error reading directory: \(error)")
    }
    return output
}
