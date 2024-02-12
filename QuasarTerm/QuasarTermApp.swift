//
//  QuasarTermApp.swift
//  QuasarTerm
//
//  Created by daniel on 15/12/23.
//

import SwiftUI

@main
struct QuasarTermApp: App {
    @Environment(\.openWindow)
    var openWindow

    var body: some Scene {
        Group {
            WindowGroup {
                ContentView()
            }

            SettingsWindow()
        }
        .windowStyle(.hiddenTitleBar)
        .windowToolbarStyle(.unifiedCompact)
        .commands {
            CommandGroup(before: CommandGroupPlacement.newItem, addition: {
                Button(action: {
                    if let currentWindow = NSApp.keyWindow,
                       let windowController = currentWindow.windowController
                    {
                        windowController.newWindowForTab(nil)
                        if let newWindow = NSApp.keyWindow, currentWindow != newWindow {
                            currentWindow.addTabbedWindow(newWindow, ordered: .above)
                        }
                    }
                }, label: {
                    Text("New Tab")
                })
                .keyboardShortcut("t", modifiers: [.command])

            })

            CommandGroup(after: CommandGroupPlacement.newItem, addition: {
                Button(action: {
                    openWindow(id: "settings")
                }, label: {
                    Text("Settings")
                })
                .keyboardShortcut(",", modifiers: [.command])
            })
        }
    }
}
