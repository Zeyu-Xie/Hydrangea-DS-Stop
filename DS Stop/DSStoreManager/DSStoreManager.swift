import SwiftUI

struct DSStoreManager: View {
    
    @State var folderPath: String?
    @State private var folderTree: String?
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Button(action: {
                    folderPath = selectFolderPath()
                    if let path = folderPath {
                        folderTree = StringifiedTree(path: path)
                    }
                }) {
                    Label("Select Folder", systemImage: "folder")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .padding([.top, .bottom])
                  
                Text("Folder Path")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                TextField(
                    "Folder Path",
                    text: .constant(folderPath ?? "No folder chosen")
                )
                .font(.system(.body, design: .monospaced))
                .lineLimit(1)
                .disabled(true)
                .textFieldStyle(.roundedBorder)
                
                Text("Folder Tree")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                FileBrowserView(rootPath: $folderPath)
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
                
            VStack(spacing: 16) {
                    
                    
                GroupBox(label: Label("Actions", systemImage: "gearshape")) {
                    VStack(spacing: 12) {
                        Button(action: {
                            let _folderPath = folderPath
                            folderPath = nil
                            folderPath = _folderPath
                        }) {
                            Label(
                                "Refresh Tree",
                                systemImage: "arrow.clockwise"
                            )
                        }
                        .buttonStyle(.bordered)
                            
                        DSStoreExportButton(folderPath: $folderPath)
                            
                        DSStoreImportButton(folderPath: $folderPath)
                            
                        DSStoreDeleteButton(folderPath: $folderPath)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}




















struct _FileNode: Identifiable {
    let id = UUID()
    let name: String
    let path: String
    var isDirectory: Bool
    var children: [_FileNode]?
}
func _loadFileSystem(at path: String) -> [_FileNode] {
    let fileManager = FileManager.default
    guard let contents = try? fileManager.contentsOfDirectory(atPath: path) else {
        return []
    }
    return contents.compactMap { name in
        let fullPath = (path as NSString).appendingPathComponent(name)
        var isDirectory: ObjCBool = false
        fileManager.fileExists(atPath: fullPath, isDirectory: &isDirectory)
        return _FileNode(
            name: name,
            path: fullPath,
            isDirectory: isDirectory.boolValue,
            children: isDirectory.boolValue ? _loadFileSystem(
                at: fullPath
            ) : nil
        )
    }
}
struct FileBrowserView: View {
    
    @Binding var rootPath: String?
    @State private var fileSystem: [_FileNode] = []
    
    var body: some View {
        List {
            if rootPath == nil {
                Text("No folder chosen").foregroundStyle(.gray)
            }
            else {
                if _loadFileSystem(at: rootPath!).isEmpty {
                    Text("Loading...")
                        .foregroundColor(.gray)
                }
                else {
                    OutlineGroup(
                        _loadFileSystem(at: rootPath!),
                        children: \.children
                    ) { node in
                        HStack {
                            Image(
                                systemName: node.isDirectory ? "folder" : "doc.text"
                            )
                            .foregroundColor(node.isDirectory ? .yellow : .blue)
                            Text(node.name)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .cornerRadius(8)
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
