import SwiftUI

struct _DSStoreInfoPanel: View {
    
    @Binding var folderPath: String?
    @Binding var selectPath: String?
    
    var body: some View {
        VStack {
            Text("Selected File Info")
            if let selectPath = selectPath {
                if (selectPath as NSString).lastPathComponent == ".DS_Store" && isFile(
                    path: selectPath
                ) {
                    loadInfoChart(selectPath: selectPath).1
                }
            }
        }
    }
    
    func loadInfoChart(selectPath: String?) -> (String, some View) {
        guard let selectPath = selectPath else {
            return ("Error: The path is nil.", InfoGrid(table: [[""]]))
        }

        let (status, infoJson) = decodeDSStore(filePath: selectPath)
        
        if status != "Success" {
            return (status, InfoGrid(table: [[""]]))
        }
        
        let fileNameList = infoJson["fileName_list"] as? Array<String> ?? []
        let codeList = infoJson["code_list"] as? Array<String> ?? []
        let dsStoreList: Dictionary<String, Dictionary<String, Any>> = infoJson["ds_store_dict"] as? Dictionary<String, Dictionary<String, Any>> ?? [:]
                        
        //        Row 0
        var _codeList: Array<String> = [""]
        for item in codeList {
            _codeList.append(item)
        }
                
        //        Row 1, 2, ...
        var _dsStoreList: Array<Array<String>> = [[""]]
        for i in 0..<fileNameList.count {
            if i > 0 {
                _dsStoreList.append([""])
            }
            let fileName: String = fileNameList[i]
            _dsStoreList[i][0] = fileName
            for j in 0..<codeList.count {
                let code: String = codeList[j]
                _dsStoreList[i]
                    .append(dsStoreList[fileName]![code] as? String ?? "")
            }
        }
        
        var table: Array<Array<String>> = [_codeList]
        for item in _dsStoreList {
            table.append(item)
        }
        
        print(table)
        
        
        return ("Success", InfoGrid(table: table))
    }
}

struct InfoGrid: View {
    
    @State var table: Array<Array<String>>
    
    var body: some View {
        
        Grid(horizontalSpacing: 10, verticalSpacing: 10) {
                   ForEach(table.indices, id: \.self) { rowIndex in
                       GridRow {
                           ForEach(table[rowIndex].indices, id: \.self) { columnIndex in
                               Text(table[rowIndex][columnIndex])
                                   .frame(minWidth: 50, maxWidth: .infinity, alignment: .center)
                                   .padding()
                                   .background(rowIndex == 0 ? Color.gray.opacity(0.2) : Color.clear) // Header row styling
                                   .border(Color.gray, width: 1)
                           }
                       }
                   }
               }
               .padding()
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
}
