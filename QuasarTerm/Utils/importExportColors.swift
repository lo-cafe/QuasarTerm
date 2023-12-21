import Defaults
import Foundation
import SwiftTerm
import SwiftUI

public func importColors() {
    // open a file dialog and import the quasar_colors.json file
    let panel = NSOpenPanel()
    panel.allowsMultipleSelection = false
    panel.canChooseDirectories = false
    panel.canChooseFiles = true
    panel.allowedContentTypes = [.json]

    panel.runModal()

    if let file = panel.url {
        do {
            let data = try Data(contentsOf: file)
            let decoder = JSONDecoder()
            let colors = try decoder.decode(ExportableColors.self, from: data)
            // save the colors to the defaults
            let cols = colors.colors
            Defaults[.ansiColors] = cols
            // update the colors in the app

        } catch {
            print(error)
        }
    } else {
        print("No file selected")
    }
}

public func exportColors() {
    // open a file dialog and export the quasar_colors.json file
    let panel = NSSavePanel()
    panel.allowedContentTypes = [.json]
    panel.nameFieldStringValue = "quasar_colors.json"
    panel.runModal()

    if let file = panel.url {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let colors = ExportableColors(colors: Defaults[.ansiColors])
        do {
            let data = try encoder.encode(colors)
            try data.write(to: file)
        } catch {
            print(error)
        }
    }
}

struct ExportableColors: Codable {
    var colors: [String]
}
