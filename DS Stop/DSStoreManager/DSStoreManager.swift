import SwiftUI
import Foundation

struct DSStoreManager: View {
    
    @State private var folderPath: String?
        
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack {
                    _DSStoreFolderSelectPanel(folderPath: $folderPath).padding()
                    Divider()
                    _DSStoreFolderTreePanel(folderPath: $folderPath).padding()
                }
                .frame(maxWidth: .infinity)
                Divider()
                _DSStoreInfoPanel(folderPath: $folderPath)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .frame(maxHeight: .infinity)
            Divider()
            _DSStoreButtonPanel(folderPath: $folderPath).padding()
        }
    }
}
