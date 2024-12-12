import SwiftUI

struct _DSStoreButtonPanel: View {
    @Binding var folderPath: String?
    var body: some View {
        HStack {
            _DSStoreRefreshButton(folderPath: $folderPath)
            _DSStoreExportButton(folderPath: $folderPath)
            _DSStoreImportButton(folderPath: $folderPath)
            Spacer()
            _DSStoreDeleteButton(folderPath: $folderPath)
        }
    }
}

struct _DSStoreRefreshButton: View{
    
    @Binding var folderPath: String?
    @State private var isPresented: Bool = false
    @State private var status: String? = nil
    
    var body: some View {
        Button(action: {
            status = refreshDSStore(folderPath: &folderPath)
            isPresented = true
        }) {
            Label("Refresh", systemImage: "arrow.clockwise")
        }
        .alert(isPresented: $isPresented) {
            if status == nil {
                return Alert(
                    title: Text("Error"),
                    message: Text("Internal error."),
                    dismissButton: .default(Text("OK"))
                )
            }
            else {
                if status == "Success" {
                    return Alert(
                        title: Text("Success"),
                        message: Text("Successfully refreshed the panels."),
                        dismissButton: .default(Text("OK"))
                    )
                }
                else {
                    return Alert(
                        title: Text("Error"),
                        message: Text(status!),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
        }
    }
}

struct _DSStoreExportButton: View {
    
    @Binding var folderPath: String?
    
    @State private var isPresented: Bool = false
    @State private var fileList: Array<String> = []
    
    var body: some View {
        Button(action: {
            if let folderPath = folderPath {
                fileList = export_DSStore(folderPath: folderPath)
            }
            isPresented = true
        }) {
            Label (
                "Export",
                systemImage: "square.and.arrow.up"
            )
            
        }
    }
}

struct _DSStoreImportButton: View {
    
    @Binding var folderPath: String?
    
    @State private var isPresented: Bool = false
    @State private var fileList: Array<String> = []
    
    var body: some View {
        
        Button(action: {
            if let folderPath = folderPath {
                fileList = import_DSStore(folderPath: folderPath)
            }
            isPresented = true
        }) {
            Label(
                "Import",
                systemImage: "square.and.arrow.down"
            )
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

struct _DSStoreDeleteButton: View {
    
    @Binding var folderPath: String?
    
    @State private var isPresented: Bool = false
    @State private var succList: Array<String> = []
    @State private var failList: Array<String> = []
    
    var body: some View {
        Button(action: {
            if let folderPath = folderPath {
                (succList, failList) = delete_DSStore(
                    folderPath: folderPath
                )
            }
            isPresented = true
        }) {
            Label(
                "Delete",
                systemImage: "xmark.bin"
            )
        }
        .buttonStyle(.borderedProminent)
        .tint(.red)
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
