//
//  ContentView.swift
//  DS Stop
//
//  Created by Zeyu Xie on 2024-12-19.
//

import SwiftUI

struct ContentView: View {
    
    @State private var output: Array<String> = []
    
    var body: some View {
        TabView {
            DSStoreManager()
                .tabItem {
                    Label(".DS_Store", systemImage: "globe")
                }
        }
    }
}
