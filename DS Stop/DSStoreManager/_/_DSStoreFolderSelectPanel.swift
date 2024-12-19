//
//  _DSStoreFolderSelectPanel.swift
//  DS Stop
//
//  Created by Zeyu Xie on 2024-12-19.
//

import SwiftUI

struct _DSStoreFolderSelectPanel: View {
    
    @Binding var folderPath: String?
    
    @State private var isPresented: Bool = false
    @State private var status: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                (status, folderPath) = selectFolderPath()
                if status != "Success" {
                    isPresented = true
                }
            }) {
                Label("Select Folder", systemImage: "folder")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom)
            .alert(isPresented: $isPresented) {
                return Alert(
                    title: Text("Path not Selected"),
                    message: Text(status),
                    dismissButton: .default(Text("OK"))
                )
            }
              
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
        }
    }
}
