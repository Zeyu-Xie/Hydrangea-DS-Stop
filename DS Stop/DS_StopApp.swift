import SwiftUI

@main
struct DS_StopApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .commands {
            CommandGroup(replacing: .appInfo) { }
            CommandGroup(after: .windowArrangement) {
                Button("Revert Window") {
//                    ?
                }
                .keyboardShortcut("r", modifiers: [.command])
            }
        }
    }
}
