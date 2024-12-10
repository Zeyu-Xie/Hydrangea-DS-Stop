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
                NavigationLink(destination: GitManager()) {
                    Label(".git", systemImage: "g.square")
                }
            }
            .padding(.vertical)
            .listStyle(SidebarListStyle())
            .navigationTitle("DS Stop")
        }
        .windowResizeBehavior(.disabled)
        .onAppear() {
            if let window = NSApplication.shared.windows.first {
                window.setContentSize(NSSize(width: 800, height: 300)) // 设置窗口初始大小
            }
            print("App Started")
        }
    }
}

#Preview {
    ContentView()
}
