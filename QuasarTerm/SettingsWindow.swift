import SwiftUI

struct SettingsWindow: Scene {
    var body: some Scene {
        Window("Settings", id: "settings") {
            SettingsView()
                .frame(minWidth: 715, maxWidth: 715)
                .task {
                    let window = NSApp.windows.first { $0.identifier?.rawValue == "settings" }!
                    window.titlebarAppearsTransparent = true
                }
        }
        .windowStyle(.automatic)
        .windowToolbarStyle(.unified)
        .windowResizability(.contentSize)
    }
}
