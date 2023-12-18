//
//  ColorFromHex.swift
//  QuasarTerm
//
//  Created by daniel on 15/12/23.
//

import Foundation
import SwiftTerm
import SwiftUI

extension SwiftUI.Color {
    init(hex: UInt, alpha: Double = 1.0) {
        // Extract red, green, and blue components from the hex value
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0x00FF00) >> 8) / 255.0
        let blue = Double(hex & 0x0000FF) / 255.0

        // Create a SwiftUI Color with the extracted components
        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }
}

extension SwiftUI.Color {
    init(hex: String, alpha _: Double = 1.0) {
        // Extract red, green, and blue components from the hex value
        let clean_hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()

        Scanner(string: clean_hex).scanHexInt64(&int)

        let r, g, b: UInt64

        switch clean_hex.count {
        case 3: // RGB (12-bit)
            (r, g, b, _) = (
                (int >> 8) * 17,
                (int >> 4 & 0xF) * 17,
                (int & 0xF) * 17,
                255
            )
        case 6: // RGB (24-bit)
            (r, g, b, _) = (
                int >> 16,
                int >> 8 & 0xFF,
                int & 0xFF,
                255
            )
        case 8: // ARGB (32-bit)
            (r, g, b, _) = (
                int >> 24,
                int >> 16 & 0xFF,
                int >> 8 & 0xFF,
                int & 0xFF
            )
        default:
            (r, g, b, _) = (1, 1, 1, 1)
        }

        // Create a SwiftUI Color with the extracted components
        // self.init(red: red, green: green, blue: blue, opacity: alpha)
        let doubleR = Double(r) / 255
        let doubleG = Double(g) / 255
        let doubleB = Double(b) / 255
        self.init(red: doubleR, green: doubleG, blue: doubleB)
    }
}

extension SwiftTerm.Color {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()

        Scanner(string: hex).scanHexInt64(&int)

        let r, g, b: UInt64

        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b, _) = (
                (int >> 8) * 17,
                (int >> 4 & 0xF) * 17,
                (int & 0xF) * 17,
                255
            )
        case 6: // RGB (24-bit)
            (r, g, b, _) = (
                int >> 16,
                int >> 8 & 0xFF,
                int & 0xFF,
                255
            )
        case 8: // ARGB (32-bit)
            (r, g, b, _) = (
                int >> 24,
                int >> 16 & 0xFF,
                int >> 8 & 0xFF,
                int & 0xFF
            )
        default:
            (r, g, b, _) = (1, 1, 1, 1)
        }

        self.init(
            red: UInt16(r << 8),
            green: UInt16(g << 8),
            blue: UInt16(b << 8)
        )
    }
}
