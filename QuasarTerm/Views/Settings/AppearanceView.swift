//
//  AppearanceView.swift
//  QuasarTerm
//
//  Created by daniel on 15/12/23.
//

import SwiftUI
import Defaults
import FontPicker
struct AppearanceView: View {
    @Default(.terminalFont) var terminalFont
    @Default(.backroundTint) var backgroundTint
    @Default(.caretColor) var caretColor
    var body: some View {
        List{
            Section("Font"){
                VStack{
                    fontPreview
                    HStack{
                        Text("Current Font: \(terminalFont.displayName ?? "no font") with size \(terminalFont.pointSize, specifier: "%.0f")")
                        Spacer()
                    }
                    HStack{
                    FontPicker("Change Font", selection: $terminalFont)
                        Spacer()
                    }
                }
            }
            Section("Colors"){
                ColorPicker("Background Color", selection: $backgroundTint)
                ColorPicker("Caret Color", selection: $caretColor)
            }
        }
        .listStyle(.sidebar)
    }
    
    
    
    var fontPreview: some View {
        Text("The quick brown fox jumps over the lazy dog")
            .font(Font(terminalFont))
    }
}



#Preview {
    AppearanceView()
}
