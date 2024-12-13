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
                    Text(decodeDSStore(filePath: selectPath).0)
                }
            }
        }
    }
}
