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

extension Defaults.Keys {
    static let terminalFont = Key<NSFont>("terminalFont", default: .monospacedSystemFont(ofSize: 12, weight: .regular))
    static let backroundTint = Key<Color>("backgroundTint", default: .clear)
    static let caretColor = Key<Color>("caretColor", default: .gray)
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
}

extension NSFont: _DefaultsSerializable {}
