import SwiftUI
import Foundation

struct DSStoreManager: View {
    
    @State var folderPath: String?
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack {
                    _DSStoreFolderSelectPanel(folderPath: $folderPath)
                    _DSStoreFolderTreePanel(folderPath: $folderPath)
                }
                .frame(maxWidth: .infinity)
                Divider()
                _DSStoreInfoPanel(folderPath: $folderPath).padding()
            }
            .frame(maxHeight: .infinity)
            Divider()
            _DSStoreButtonPanel(folderPath: $folderPath)
        }
    }
}
