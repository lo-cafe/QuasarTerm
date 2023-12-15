//
//  Defaults.swift
//  QuasarTerm
//
//  Created by daniel on 15/12/23.
//

import Foundation
import Defaults
import AppKit
import SwiftUI

extension Defaults.Keys {
    static let terminalFont = Key<NSFont>("terminalFont", default: .monospacedSystemFont(ofSize: 12, weight: .regular))
    static let backroundTint = Key<Color>("backgroundTint", default: .clear)
    static let caretColor = Key<Color>("caretColor", default: .gray)
}

extension NSFont: _DefaultsSerializable {}
    
