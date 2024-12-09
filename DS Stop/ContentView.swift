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
