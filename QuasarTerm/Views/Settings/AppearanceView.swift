//
//  AppearanceView.swift
//  QuasarTerm
//
//  Created by daniel on 15/12/23.
//

import Defaults
import FontPicker
import SwiftUI

struct AppearanceView: View {
    @Default(.terminalFont) var terminalFont
    @Default(.backroundTint) var backgroundTint
    @Default(.caretColor) var caretColor
    var body: some View {
        Form {
            Section("Font") {
                HStack{
                    fontPreview
                }
                
                HStack {
                    Text("Current Font:")
                        .fontWeight(.medium)
                    Text(terminalFont.displayName ?? "no font")
                    Spacer()
                    FontPicker("", selection: $terminalFont)
                }
                
                
                HStack {
                    Text("Font Size:")
                        .fontWeight(.medium)
                    Text("\(terminalFont.pointSize, specifier: "%.0f")")
                    Spacer()
                }
            }
            Section("Colors") {
                ColorPicker("Background Color", selection: $backgroundTint)
                ColorPicker("Caret Color", selection: $caretColor)
                Text("ANSI Colors")
                    .font(.caption)
                    .fontWeight(.medium)
                    .opacity(0.4)
                HStack {
                    VStack {
                        ColorPickerElement(title: "Black", index: 0)
                        ColorPickerElement(title: "Red", index: 1)
                        ColorPickerElement(title: "Green", index: 2)
                        ColorPickerElement(title: "Yellow", index: 3)
                        ColorPickerElement(title: "Blue", index: 4)
                        ColorPickerElement(title: "Magenta", index: 5)
                        ColorPickerElement(title: "Cyan", index: 6)
                        ColorPickerElement(title: "White", index: 7)
                    }
                    VStack {
                        ColorPickerElement(title: "Bright Black", index: 8)
                        ColorPickerElement(title: "Bright Red", index: 9)
                        ColorPickerElement(title: "Bright Green", index: 10)
                        ColorPickerElement(title: "Bright Yellow", index: 11)
                        ColorPickerElement(title: "Bright Blue", index: 12)
                        ColorPickerElement(title: "Bright Magenta", index: 13)
                        ColorPickerElement(title: "Bright Cyan", index: 14)
                        ColorPickerElement(title: "Bright White", index: 15)
                    }
                }

                HStack {
                    Button { importColors() } label: {
                        Text("Import Colors")
                    }

                    Button { exportColors() } label: {
                        Text("Export Colors")
                    }
                }
            }
        }.formStyle(.grouped)
    }

    var fontPreview: some View {
        Text("The quick brown fox jumps over the lazy dog")
            .font(Font(terminalFont))
            .frame(maxWidth: .infinity)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(backgroundTint)
            }
    }
}

struct ColorPickerElement: View {
    var title: String
    var index: Int
    @Default(.ansiColors) var ansiColors
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Circle()
                .fill(Color(hex: ansiColors[index]))
                .frame(width: 20, height: 20)
        }
        .frame(maxWidth: 150)
    }
}
