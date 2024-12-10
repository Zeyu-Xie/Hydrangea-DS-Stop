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
                        func_export(folderPath: folderPath)
                    }
                    else {
                        print("Folder Path Not Loaded")
                    }
                    
                }
                Button("Import") {
                    if let folderPath = folderPath {
                        func_import(folderPath: folderPath)
                    }
                    else {
                        print("Folder Path Not Loaded")
                    }
                }
                Button("Delete") {
                    if let folderPath = folderPath {
                        func_delete(folderPath: folderPath)
                    }
                    else {
                        print("Folder Path Not Loaded")
                    }
                }
            }.frame(maxWidth: .infinity)
                
        }
    }
}

