import SwiftUI
import Foundation

struct DSStoreManager: View {
    
    @State private var folderPath: String?
    @State private var selectPath: String?
        
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack {
                    _DSStoreFolderSelectPanel(folderPath: $folderPath).padding()
                    Divider()
                    _DSStoreFolderTreePanel(
                        folderPath: $folderPath,
                        selectPath: $selectPath
                    )
                    .padding()
                }
                .frame(width: 384)
                Divider()
                VStack(alignment: .leading) {
                    _DSStoreInfoPanel(
                        folderPath: $folderPath,
                        selectPath: $selectPath
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                .frame(width: 600)
            }
            Divider()
            _DSStoreButtonPanel(
                folderPath: $folderPath,
                selectPath: $selectPath
            )
            .padding()
        }
    }
}
