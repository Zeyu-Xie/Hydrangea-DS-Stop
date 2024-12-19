//
//  _DSStoreButtonPanel.swift
//  DS Stop
//
//  Created by Zeyu Xie on 2024-12-19.
//

import SwiftUI

struct _DSStoreButtonPanel: View {
    @Binding var folderPath: String?
    @Binding var selectPath: String?
    var body: some View {
        HStack {
            _DSStoreRefreshButton(folderPath: $folderPath)
            _DSStoreExportButton(folderPath: $folderPath)
            _DSStoreImportButton(folderPath: $folderPath)
            Spacer()
            _DSStoreQuitButton()
            _DSStoreDeleteButton(folderPath: $folderPath, selectPath: $selectPath)
        }
    }
}

struct _DSStoreRefreshButton: View{
    
    @Binding var folderPath: String?
    @State private var isPresented: Bool = false
    @State private var status: String? = nil
    
    var body: some View {
        Button(action: {
            let originalValue = folderPath
            folderPath = nil
            folderPath = originalValue
            status = "Success"
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
    
    @State private var fileList: Array<String> = []
    
    var body: some View {
        Button(action: {
            if let folderPath = folderPath {
                (_, fileList) = export_DSStore(folderPath: folderPath)
            }
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
    @State private var status: String = ""
    @State private var fileList: Array<String> = []
    var body: some View {
        
        Button(action: {
            (status, fileList) = import_DSStore(folderPath: folderPath)
            isPresented = true
        }) {
            Label(
                "Import",
                systemImage: "square.and.arrow.down"
            )
        }
        .alert(isPresented: $isPresented) {
            if status != "Success" {
                return Alert(
                    title: Text("Import Failed"),
                    message: Text(status),
                    dismissButton: .default(Text("OK"))
                )
            }
            else {
                return Alert(
                    title: Text("Import Successful"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

struct _DSStoreQuitButton: View {
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        Button(action: {
            isPresented = true
        }) {
            Label("Quit", systemImage: "xmark")
        }
        .alert(isPresented: $isPresented) {
            return Alert(
                title: Text("Quit DS Stop"),
                message: Text("Do you really want to quit DS Stop?"),
                primaryButton: .destructive(Text("Quit"), action: {
                    NSApplication.shared.terminate(self)
                }),
                secondaryButton: .cancel()
            )
        }
    }
}

struct _DSStoreDeleteButton: View {
    
    @Binding var folderPath: String?
    @Binding var selectPath: String?
    
    @State private var isPresented: Bool = false
    @State private var status: String = ""
    @State private var fileList: Array<String> = []
    
    var body: some View {
        Button(action: {
            (status, fileList) = delete_DSStore(
                folderPath: folderPath
            )
            selectPath = nil
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
            if status != "Success" {
                return Alert(
                    title: Text("Delete Failed"),
                    message: Text(status),
                    dismissButton: .default(Text("OK"))
                )
            }
            else {
                
                var alertMessage: String = ""
                
                if fileList.isEmpty {
                    alertMessage = "No files deleted."
                }
                else {
                    alertMessage = "Successfullt deleted the following files:\n" + fileList
                        .joined(separator: "\n")
                }
                
                return Alert(
                    title: Text("Delete Successful"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}
