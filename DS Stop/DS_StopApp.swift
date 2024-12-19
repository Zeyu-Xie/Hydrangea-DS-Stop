//
//  DS_StopApp.swift
//  DS Stop
//
//  Created by Zeyu Xie on 2024-12-19.
//

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
