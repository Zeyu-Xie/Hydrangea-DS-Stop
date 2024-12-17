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
                            Text(table[rowIndex][columnIndex])
                                .frame(
                                    minWidth: 100,
                                    alignment: .center
                                ) // 设定列宽
                                .padding() // 增加内边距
                                .background(
                                    rowIndex == 0 ? Color.blue
                                        .opacity(0.2) : Color.gray
                                        .opacity(0.1)
                                ) // 区分表头和内容
                                .cornerRadius(4) // 添加圆角
                                .border(Color.gray, width: 0.5) // 添加边框
                                .multilineTextAlignment(.center)
                        }
                    }
                    .background(
                        rowIndex == 0 ? Color.blue.opacity(0.4) : Color.clear
                    )
                }
            }
            .padding(.vertical)
        }
    }
}
