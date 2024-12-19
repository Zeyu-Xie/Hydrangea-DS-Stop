//
//  DSStoreManager.swift
//  DS Stop
//
//  Created by Zeyu Xie on 2024-12-19.
//

import SwiftUI
import Foundation

struct DSStoreManager: View {
    
    @State private var folderPath: String?
    @State private var selectPath: String?
        
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .center) {
                    _DSStoreFolderSelectPanel(folderPath: $folderPath).padding()
                    Divider()
                    _DSStoreFolderTreePanel(
                        folderPath: $folderPath,
                        selectPath: $selectPath
                    )
                    .padding()
                }
                .frame(minWidth: 300)
                Divider()
                VStack(alignment: .leading) {
                    _DSStoreInfoPanel(
                        folderPath: $folderPath,
                        selectPath: $selectPath
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }
                .frame(minWidth: 400)
            }
            .frame(minHeight: 400)
            Divider()
            _DSStoreButtonPanel(
                folderPath: $folderPath,
                selectPath: $selectPath
            )
            .padding()
        }
    }
}
