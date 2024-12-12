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
