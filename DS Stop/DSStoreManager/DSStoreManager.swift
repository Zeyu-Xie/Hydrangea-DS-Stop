import SwiftUI

struct DSStoreManager: View {
    @State private var folderPath: String?
    var body: some View {
        HStack {
            VStack {
                Button("Select Folder", action: {
                    folderPath = selectFolderPath()
                })
                if let folderPath = folderPath {
                    Text("Folder Path: \(folderPath)")
                }
            }
            .frame(maxWidth: .infinity)
            VStack {
                Button("Export") {
                    if let folderPath = folderPath {
                        func_export_DSStore(folderPath: folderPath)
                    }
                    else {
                        print("Folder Path Not Loaded")
                    }
                    
                }
                Button("Import") {
                    if let folderPath = folderPath {
                        func_import_DSStore(folderPath: folderPath)
                    }
                    else {
                        print("Folder Path Not Loaded")
                    }
                }
                Button("Delete") {
                    if let folderPath = folderPath {
                        func_delete_DSStore(folderPath: folderPath)
                    }
                    else {
                        print("Folder Path Not Loaded")
                    }
                }
            }.frame(maxWidth: .infinity)
                
        }
    }
}

