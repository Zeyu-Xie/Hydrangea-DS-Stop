import SwiftUI

struct GitManager: View {
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
                Button("Delete") {
                    if let folderPath = folderPath {
                        func_delete_Git(folderPath: folderPath)
                    }
                    else {
                        print("Folder Path Not Loaded")
                    }
                }
            }.frame(maxWidth: .infinity)
                
        }
    }
}

