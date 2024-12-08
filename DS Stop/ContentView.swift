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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            List(output, id: \.self) { item in
                Text(item)
            }
            .padding()
        }
        .padding()
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
