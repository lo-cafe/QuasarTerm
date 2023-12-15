//
//  SettingsView.swift
//  QuasarTerm
//
//  Created by daniel on 15/12/23.
//

import SwiftUI
import Defaults
import FontPicker
struct SettingsView: View {
    var body: some View {
        
        NavigationView{
            List{
                NavigationLink(destination: {
                    AppearanceView()
                }, label: {
                    Label("Appearance", systemImage: "paintbrush")
                })
          
            }.listStyle(.sidebar)
        }
        .toolbar(removing: .sidebarToggle)
    }
}

#Preview {
    SettingsView()
}
