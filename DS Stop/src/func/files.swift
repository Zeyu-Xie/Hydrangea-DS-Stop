import AppKit
import Foundation
import UniformTypeIdentifiers

func isFile(path: String) -> Bool {
    var isDirectory: ObjCBool = false
    return FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory) && !isDirectory.boolValue
}

func isDir(path: String) -> Bool {
    var isDirectory: ObjCBool = false
    return FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory) && isDirectory.boolValue    
}

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

func _stringifyTree(tree: Dictionary<String, Any>, indent: Int = 0) -> String {
    var output = ""
    for (key, value) in tree {
        if value is String {
            output += String(repeating: " ", count: indent) + "  " + key + "\n"
        } else if value is Dictionary<String, Any> {
            output += String(repeating: " ", count: indent) + "- " + key + "\n"
            output += _stringifyTree(tree: value as! Dictionary<String, Any>, indent: indent + 2)
        }
    }
    return output
}

func tree(path: String) -> String {
    return _stringifyTree(tree: _listTree(path: path))
}

func exportFile(
    content: Data,
    defaultFileName: String,
    allowedType: Array<UTType>,
    title: String = "Export File"
) {
    let panel = NSSavePanel()
    panel.title = title
    panel.allowedContentTypes = allowedType
    panel.nameFieldStringValue = defaultFileName
    panel.begin { response in
        if response == .OK, let url = panel.url {
            do {
                try content.write(to: url)
                print("File saved at \(url)")
            } catch {
                print("Failed to save file: \(error.localizedDescription)")
            }
        } else {
            print("User cancelled the operation")
        }
    }
}


// Select a file, and return its path
func selectFilePath() -> String? {
    let openPanel = NSOpenPanel()
    openPanel.title = "Select File"
    openPanel.canChooseFiles = true
    openPanel.canChooseDirectories = false
    openPanel.allowsMultipleSelection = false
    if openPanel.runModal() == .OK, let selectedURL = openPanel.url {
        return selectedURL.path
    }
    return nil
}

// Select a folder, and return its path
func selectFolderPath() -> String? {
    let openPanel = NSOpenPanel()
    openPanel.title = "Select Folder"
    openPanel.canChooseFiles = false
    openPanel.canChooseDirectories = true
    openPanel.allowsMultipleSelection = false
    if openPanel.runModal() == .OK, let selectedURL = openPanel.url {
        return selectedURL.path
    }
    return nil
}
