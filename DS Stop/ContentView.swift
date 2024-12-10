// Wri

import SwiftUI

struct ContentView: View {
    
    @State private var output: Array<String> = []
    
    var body: some View {
        NavigationView() {
            List {
                NavigationLink(destination: DSStoreManager()) {
                    Label(".DS_Store", systemImage: "d.square")
                }
                NavigationLink(destination: Text("Dealing with .DS_Store")) {
                    Label(".git", systemImage: "g.square")
                }
            }
            .padding(.vertical)
            .listStyle(SidebarListStyle())
            .navigationTitle("DS Stop")
        }
        .onAppear() {
//            let fls = extractFile(directory: "/Users/zeyuxie/Downloads", fileNames: [".DS_Store", "444"])
//            print(fls)
//            let enc = treeEncodor(files: fls, rootPath: "/Users/zeyuxie/Downloads")
//            print(enc)
        }
    }
}

#Preview {
    ContentView()
}
