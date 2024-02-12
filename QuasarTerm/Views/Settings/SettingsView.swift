//
//  SettingsView.swift
//  QuasarTerm
//
//  Created by daniel on 15/12/23.
//

import Defaults
import FontPicker
import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: {
                    GeneralSettingsView()
                }, label: {
                    Label("General", systemImage: "gear")
                })
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
