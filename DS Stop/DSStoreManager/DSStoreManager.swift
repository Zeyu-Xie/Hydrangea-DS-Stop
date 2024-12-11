import SwiftUI

struct DSStoreManager: View {
    
    @State private var folderPath: String?
    @State private var folderTree: String?
    
    var body: some View {
        HStack {
            // Left part - Select the folder
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
                    folderTree = StringifiedTree(path: folderPath!)
                })
                .padding()
                Text("Folder Path:").padding()
                if let folderPath = folderPath {
                    Text(folderPath)
                        .monospaced()
                        .padding()
                }
            }
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.leading)
            
            Divider()
            
            // Right part - action buttons
            VStack {
                if folderPath != nil {
                    VStack(alignment: .leading, spacing: 16) {
                        ScrollView {
                            Text(folderTree ?? "")
                                .font(.system(.body, design: .monospaced))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .scrollIndicators(.hidden)
                    }
                    .padding()
                    Divider()
                }
                VStack {
                    Button("Refresh Tree") {
                        if let folderPath = folderPath {
                            folderTree = StringifiedTree(path: folderPath)
                        }
                    }.padding()
                    DSStoreExportButton(folderPath: $folderPath).padding()
                    DSStoreImportButton(folderPath: $folderPath).padding()
                    DSStoreDeleteButton(folderPath: $folderPath).padding()
                }
            }.frame(maxWidth: .infinity)
        }
    }
}

struct DSStoreExportButton: View {
    
    @Binding var folderPath: String?
    
    @State private var isPresented: Bool = false
    @State private var fileList: Array<String> = []
    
    var body: some View {
        Button("Export") {
            if let folderPath = folderPath {
                fileList = export_DSStore(folderPath: folderPath)
                fileList = fileList.map { folderPath + $0 }
            }
            isPresented = true
        }
        .alert(isPresented: $isPresented) {
            if folderPath == nil {
                return Alert(
                    title: Text("Error"),
                    message: Text("Folder Path Not Loaded"),
                    dismissButton: .default(Text("OK"))
                )
            }
            else {
                return Alert(
                    title: Text("Success"),
                    message: Text(
                        "The following files are exported:\n" + fileList
                            .joined(separator: "\n")
                    ),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

struct DSStoreImportButton: View {
    
    @Binding var folderPath: String?
    
    @State private var isPresented: Bool = false
    @State private var fileList: Array<String> = []
    
    var body: some View {
        
        Button("Import") {
            if let folderPath = folderPath {
                fileList = import_DSStore(folderPath: folderPath)
                fileList = fileList.map { folderPath + $0 }
            }
            isPresented = true
        }
        .alert(isPresented: $isPresented) {
            if folderPath == nil {
                return Alert(
                    title: Text("Error"),
                    message: Text("Folder path not loaded"),
                    dismissButton: .default(Text("OK"))
                )
            }
            else {
                return Alert(
                    title: Text("Success"),
                    message: Text(
                        "Successfully write to these files:\n" + fileList
                            .joined(separator: "\n")
                    ),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        
    }
}


struct DSStoreDeleteButton: View {
    
    @Binding var folderPath: String?
    
    @State private var isPresented: Bool = false
    @State private var succList: Array<String> = []
    @State private var failList: Array<String> = []
    
    var body: some View {
        Button("Delete") {
            if let folderPath = folderPath {
                (succList, failList) = delete_DSStore(
                    folderPath: folderPath
                )
            }
            isPresented = true
        }
        .alert(isPresented: $isPresented) {
            if folderPath == nil {
                return Alert(
                    title: Text("Error"),
                    message: Text("Folder path not loaded"),
                    dismissButton: .default(Text("OK"))
                )
            }
            else {
                
                var alertMessage: String = ""

                if succList.count > 0 {
                    alertMessage += "Successfullt deleted the following files:\n" + succList
                        .joined(separator: "\n")
                }
                if failList.count > 0 {
                    if succList.count > 0 {
                        alertMessage += "\n"
                    }
                    alertMessage += "Failed to delete the following files:\n" + failList
                        .joined(separator: "\n")
                }
                
                return Alert(
                    title: Text("Delete Finished"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}
