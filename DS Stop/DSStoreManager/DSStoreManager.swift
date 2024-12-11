import SwiftUI

struct DSStoreManager: View {
    @State private var folderPath: String?
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Select Your Target Folder")
                    .font(.title)
                    .padding()
                Text(
                    "Select one folder to export, import, or delete the .DS_Store file."
                )
                .padding()
                Button("Select Folder", action: {
                    folderPath = selectFolderPath()
                })
                .padding()
                if let folderPath = folderPath {
                    Text("Folder Path: \(folderPath)").padding()
                }
            }
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.leading)
            Divider()
            VStack {
                if let folderPath = folderPath {
                    VStack(alignment: .leading, spacing: 16) {
                        ScrollView {
                            Text(tree(path: folderPath))
                                .font(.system(.body, design: .monospaced))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .scrollIndicators(.hidden)
                    }
                    .padding()
                    Divider()
                }
                VStack {
                    Button("Export") {
                        if let folderPath = folderPath {
                            func_export_DSStore(folderPath: folderPath)
                        }
                        else {
                            print("Folder Path Not Loaded")
                        }
                        
                    }.padding()
                    Button("Import") {
                        if let folderPath = folderPath {
                            func_import_DSStore(folderPath: folderPath)
                        }
                        else {
                            print("Folder Path Not Loaded")
                        }
                    }.padding()
                    Button("Delete") {
                        if let folderPath = folderPath {
                            func_delete_DSStore(folderPath: folderPath)
                        }
                        else {
                            print("Folder Path Not Loaded")
                        }
                    }.padding()
                }
            }.frame(maxWidth: .infinity)
                
        }
    }
}

