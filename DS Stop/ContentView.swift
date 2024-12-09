//
//  ContentView.swift
//  DS Stop
//
//  Created by Zeyu Xie on 2024-12-08.
//

import SwiftUI

struct ContentView: View {
    
    @State private var output: Array<String> = []
    
    var body: some View {
        NavigationView() {
            List {
                NavigationLink(destination: Text("Dealing with .DS_Store")) {
                    Label(".DS_Store", systemImage: "globe")
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("DS Stop")
        }
        .onAppear() {
            output = getSpecifiedFile(
                fromDirectory: "/Users/zeyuxie/Downloads/",
                targetFile: "1"
            )
        }
    }
}

#Preview {
    ContentView()
}
