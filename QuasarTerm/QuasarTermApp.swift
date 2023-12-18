//
//  QuasarTermApp.swift
//  QuasarTerm
//
//  Created by daniel on 15/12/23.
//

import SwiftUI

@main
struct QuasarTermApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(.hiddenTitleBar)
        .windowToolbarStyle(.unifiedCompact)
        .commands {
            CommandGroup(before: CommandGroupPlacement.newItem, addition: {
                Button(action: {
                    if let currentWindow = NSApp.keyWindow,
                       let windowController = currentWindow.windowController {
                        windowController.newWindowForTab(nil)
                        if let newWindow = NSApp.keyWindow, currentWindow != newWindow {
                            currentWindow.addTabbedWindow(newWindow, ordered: .above)
                        }
                    }
                }, label: {
                    Text("New Tab")
                })
                .keyboardShortcut("t", modifiers: [.command])
                
                Button(action: {
                    if let currentWindow = NSApp.keyWindow {
                       let newWindow = AdvancedToolbarWindow(withTitle: "Settings", {
                            SettingsView()
                        })
                        currentWindow.addChildWindow(newWindow, ordered: .above)
                        
                    }
                }, label: {
                    Text("Settings")
                })
                 .keyboardShortcut(",", modifiers: [.command])
            })
        }
    }
}
