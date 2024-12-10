import Foundation

func treeEncodor(files: Array<String>, rootPath: String) -> [String: Data] {
    var output: [String: Data] = [:]
    for file in files {
        var isDirectory: ObjCBool = false
        if FileManager.default.fileExists(atPath: file, isDirectory: &isDirectory), !isDirectory.boolValue {
            let url = URL(fileURLWithPath: file)
            do {
                let fileContent = try Data(contentsOf: url)
                let relativePath = url.path.replacingOccurrences(of: rootPath, with: "")
                output[relativePath] = fileContent
            } catch {
                print("Failed to read file at \(file): \(error)")
            }
        }
    }
    return output
}