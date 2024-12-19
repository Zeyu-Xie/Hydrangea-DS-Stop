//
//  _DSStoreFolderTreePanel.swift
//  DS Stop
//
//  Created by Zeyu Xie on 2024-12-19.
//

import SwiftUI

struct _DSStoreFolderTreePanel: View {
    
    @Binding var folderPath: String?
    @Binding var selectPath: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Folder Tree")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            FileBrowserView(rootPath: $folderPath, selectPath: $selectPath)
        }
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
    @Binding var selectPath: String?
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
                        .onTapGesture {
                            selectPath = node.path
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .cornerRadius(8)
    }
}
