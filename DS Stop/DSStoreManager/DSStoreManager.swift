import SwiftUI

struct DSStoreManager: View {
    @State private var folderPath: String?
    var body: some View {
        HStack {
            VStack {
                FolderSelectorView(folderPath: $folderPath)
                if let folderPath = folderPath {
                    Text("Folder Path: \(folderPath)")
                }
            }
            .frame(maxWidth: .infinity)
            VStack {
                Button("Export") {
                    if let folderPath = folderPath {
                        let encodedFile = treeEncodor(
                            files: extractFile(
                                directory: folderPath,
                                fileNames: [".DS_Store"]
                            ),
                            rootPath: folderPath
                        )
                        do {
                            let content = try JSONEncoder().encode(encodedFile)
                            exportFile(
                                content: content,
                                defaultFileName: "export.bin",
                                allowedType: [.data]
                            )
                        } catch {
                            print("Failed to encode JSON: \(error)")
                        }
                        
                    }
                    else {
                        print("Folder Path Not Loaded")
                    }
                    
                }
                Button("Import") {
                    print("Import func")
                }
                Button("Delete") {
                    print("Delete func")
                }
            }.frame(maxWidth: .infinity)
                
        }
    }
}

