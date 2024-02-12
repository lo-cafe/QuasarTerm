//
//  Defaults.swift
//  QuasarTerm
//
//  Created by daniel on 15/12/23.
//

import AppKit
import Defaults
import Foundation
import SwiftUI
import SwiftTerm

extension Defaults.Keys {
    static let terminalFont = Key<NSFont>("terminalFont", default: .monospacedSystemFont(ofSize: 12, weight: .regular))
    static let backroundTint = Key<SwiftUI.Color>("backgroundTint", default: .clear)
    static let caretColor = Key<SwiftTerm.Color?>("caretColor", default: SwiftTerm.Color(red: 255, green: 255, blue: 255))
    static let shellProgram = Key<String>("shellProgram", default: "/bin/zsh")
    static let shellArguments = Key<[String]>("shellProgram", default: [])
    static let ansiColors = Key<[String]>("ansiColors", default: [
        "#494D64", // black
        "#ED8796", // red
        "#A6DA95", // green
        "#EED49F", // yellow
        "#8AADF4", // blue
        "#F5BDE6", // magenta
        "#8BD5CA", // cyan
        "#B8C0E0", // white

        "#5B6078", // brightBlack
        "#ED8796", // brightRed
        "#A6DA95", // brightGreen
        "#EED49F", // brightYellow
        "#8AADF4", // brightBlue
        "#F5BDE6", // brightMagenta
        "#8BD5CA", // brightCyan
        "#A5ADCB", // brightWhite
    ])
    static let padding = Key<TerminalPadding>("padding", default: TerminalPadding(top: 0, bottom: 0, leading: 0, trailing: 0))
    static let cursorStyle = Key<CursorStyle>("cursorStyle", default: CursorStyle.blinkBar)
}

extension NSFont: _DefaultsSerializable {}
extension CursorStyle: _DefaultsSerializable {}

extension SwiftTerm.Color: _DefaultsSerializable {
    
    func serialize() {
        // Convert color components to a dictionary or directly to Data if more appropriate
        let components = ["red": self.red, "green": self.green, "blue": self.blue]
        let data = try? JSONSerialization.data(withJSONObject: components, options: [])
        UserDefaults.standard.set(data, forKey: "SwiftTerm.Color")
    }
    
    static func deserialize() -> SwiftTerm.Color? {
        guard let data = UserDefaults.standard.data(forKey: "SwiftTerm.Color"),
              let components = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: CGFloat],
              let red = components["red"],
              let green = components["green"],
              let blue = components["blue"] else {
            return nil
        }
        
        // Assuming SwiftTerm.Color can be initialized with these components
        return SwiftTerm.Color(red: UInt16(red), green: UInt16(green), blue: UInt16(blue))
    }
}


struct TerminalPadding: _DefaultsSerializable {
    var top: CGFloat
    var bottom: CGFloat
    var leading: CGFloat
    var trailing: CGFloat
    
    // Function to serialize the struct to UserDefaults
    func serialize() {
        let data = try? JSONEncoder().encode(self)
        UserDefaults.standard.set(data, forKey: "TerminalPadding")
    }
    
    // Function to deserialize the struct from UserDefaults
    static func deserialize() -> TerminalPadding? {
        guard let data = UserDefaults.standard.data(forKey: "TerminalPadding") else { return nil }
        return try? JSONDecoder().decode(TerminalPadding.self, from: data)
    }
}

extension TerminalPadding: Codable {
    enum CodingKeys: String, CodingKey {
        case top, bottom, leading, trailing
    }
}
