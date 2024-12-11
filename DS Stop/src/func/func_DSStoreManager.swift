import Foundation
import SwiftUI

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

// Export .DS_Store data as a binary file
func export_DSStore(folderPath: String) -> Array<String> {
    let encodedFile = _treeEncodor(
        files: _extractFile(
            rootPath: folderPath,
            fileNames: [".DS_Store"]
        ),
        rootPath: folderPath
    )
    do {
        let content = try JSONEncoder().encode(encodedFile)
        writeFile(
            content: content,
            defaultFileName: "export.bin",
            allowedType: [.data]
        )
        return Array(encodedFile.keys)
    } catch {
        return []
    }
    
}

// Import the binary file to recover .DS_Store
func import_DSStore(folderPath: String) -> Array<String> {
    if !isDir(path: folderPath) {
        return []
    }
    var binPath: String = ""
    let openPanel = NSOpenPanel()
    openPanel.title = "Select Binary File"
    openPanel.canChooseFiles = true
    openPanel.canChooseDirectories = false
    openPanel.allowsMultipleSelection = false
    if openPanel.runModal() == .OK, let selectedURL = openPanel.url {
        binPath = selectedURL.path
    }
    else {
        print("User cancelled the operation")
        return []
    }
    let url = URL(fileURLWithPath: binPath)
    do {
        let data = try Data(contentsOf: url)
        let decodedFile = try JSONDecoder().decode(
            [String: Data].self,
            from: data
        )
        for (relativePath, fileContent) in decodedFile {
            let filePath = folderPath + relativePath
            let fileURL = URL(fileURLWithPath: filePath)
            do {
                try fileContent.write(to: fileURL)
                print("File saved at \(fileURL)")
            } catch {
                print("Failed to save file at \(fileURL): \(error)")
            }
        }
        return Array(decodedFile.keys)
    } catch {
        print("Failed to decode JSON: \(error)")
        return []
    }
}

// Recursively delete .DS_Store
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
