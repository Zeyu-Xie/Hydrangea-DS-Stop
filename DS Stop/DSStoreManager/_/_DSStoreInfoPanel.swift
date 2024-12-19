//
//  _DSStoreInfoPanel.swift
//  DS Stop
//
//  Created by Zeyu Xie on 2024-12-19.
//

import SwiftUI

struct _DSStoreInfoPanel: View {
    
    @Binding var folderPath: String?
    @Binding var selectPath: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Selected File Info")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            if let selectPath = selectPath {
                if (selectPath as NSString).lastPathComponent == ".DS_Store" && isFile(
                    path: selectPath
                ) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        loadInfoChart(selectPath: selectPath).1
                    }.frame(maxWidth: .infinity)
                }
            }
        }
        .onChange(of: folderPath, {
            selectPath = nil
        })
    }
    
    func loadInfoChart(selectPath: String?) -> (String, some View) {
                        
        guard let selectPath = selectPath else {
            return (
                "Error: The path is nil.",
                _InfoGrid(status: "Error", table: [[]])
            )
        }
        
        let (status, infoText) = decodeDSStore(filePath: selectPath)
        
        if status != "Success" {
            return (status, _InfoGrid(status: "Error", table: [[]]))
        }
        
        let tableRows = infoText.split(separator: "\n")
        let tableItems = tableRows.map { row -> [String] in
            var items: [String] = []
            var currentItem = ""
            var insideQuotes = false

            for char in row {
                if char == "\"" {
                    insideQuotes.toggle()
                } else if char == "," && !insideQuotes {
                    items.append(currentItem)
                    currentItem = ""
                } else {
                    currentItem.append(char)
                }
            }
            items.append(currentItem)
            return items.map { $0.trimmingCharacters(in: .whitespaces) }
        }
        
        return (status, _InfoGrid(status: "Success", table: tableItems))
    }
}

struct _InfoGrid: View {
    @State var status: String?
    @State var table: Array<Array<String>>
    
    @State private var isPresented: Bool = false
    @State private var presentText: String? = nil
    
    var body: some View {
        if status != "Success" {
            EmptyView()
        }
        else {
            
            Grid {
                ForEach(table.indices, id: \.self) { rowIndex in
                    GridRow {
                        ForEach(
                            table[rowIndex].indices,
                            id: \.self
                        ) { columnIndex in
                            
                            if rowIndex == 0 {
                                Text(table[rowIndex][columnIndex])
                                    .bold()
                                    .frame(maxWidth: 150)
                                    .padding()
                                    .multilineTextAlignment(.center)
                                    .background(.blue)
                                    .cornerRadius(8)
                            }
                            
                            else {
                                Button(action: {
                                    presentText = table[rowIndex][columnIndex]
                                    isPresented = true
                                }) {
                                    Text(table[rowIndex][columnIndex])
                                }
                                .buttonStyle(LinkButtonStyle())
                                .frame(maxWidth: 150)
                                .padding()
                                .multilineTextAlignment(.center)
                                .alert(isPresented: $isPresented) {
                                    return Alert(
                                        title: Text("Item Info"),
                                        message: Text(presentText!),
                                        dismissButton: .default(Text("OK"))
                                    )
                                }
                            }
                        }
                    }
                }
            }
            .padding(.vertical)
        }
    }
}
