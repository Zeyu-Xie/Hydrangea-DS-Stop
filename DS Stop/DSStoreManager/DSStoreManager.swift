import SwiftUI

struct DSStoreManager: View {
        
    var body: some View {
        NavigationView() {
            List {
                NavigationLink(destination: Text("Export Function")) {
                    Label("Export", systemImage: "square.and.arrow.up")
                }
                NavigationLink(destination: Text("Imort Function")) {
                    Label("Import", systemImage: "square.and.arrow.down")
                }
                NavigationLink(destination: Text("Delete Function")) {
                    Label("Delete", systemImage: "xmark.bin")
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle(".DS_Store Manager")
        }
    }
}
