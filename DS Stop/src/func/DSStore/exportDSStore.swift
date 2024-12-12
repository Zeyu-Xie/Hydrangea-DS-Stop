import Foundation

func export_DSStore(folderPath: String?) -> (String, Array<String>) {
    
    if folderPath == nil {
        return ("Error: The folder path is nil.", [])
    }
    
    if !isDir(path: folderPath!) {
        return ("Error: The path does not correspond to a folder.", [])
    }
    
    let (status_1, fileList) = _extractFile(
        folderPath: folderPath!,
        fileNames: [".DS_Store"]
    )
    
    if status_1 != "Success" {
        return (status_1, [])
    }
    
    let (status_2, extractedFile) = _treeEncodor(
        files: fileList,
        folderPath: folderPath!
    )
    
    if status_2 != "Success" {
        return (status_2, [])
    }
    
    let exportedFileName = "DS_Store_Data_Exported.bin"
    
    do {
        let content = try JSONEncoder().encode(extractedFile)
        writeFile(
            content: content,
            defaultFileName: exportedFileName,
            allowedType: [.data]
        )
        let output = fileList.map { folderPath! + $0 }
        return ("Success", output)
    } catch {
        return ("Error: Failed to export the file \(exportedFileName).", [])
    }
    
}
