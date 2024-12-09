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
                    print("Export func")
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

