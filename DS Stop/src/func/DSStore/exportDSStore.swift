import Foundation

// Export .DS_Store data as a binary file
// Return the list of the path of the recorded .DS_Store files
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
            defaultFileName: "DS_Store_Data_Exported.bin",
            allowedType: [.data]
        )
        return Array(encodedFile.keys).map { folderPath + $0 }
    } catch {
        return []
    }
    
}
