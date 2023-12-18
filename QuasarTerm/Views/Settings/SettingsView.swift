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
                    AppearanceView()
                }, label: {
                    Label("Appearance", systemImage: "paintbrush")
                })
                NavigationLink(destination:
                    TestView(),
                    label: {
                        Label("Test", systemImage: "pencil")
                    })
            }.listStyle(.sidebar)
        }

        .toolbar(removing: .sidebarToggle)
    }
}

#Preview {
    SettingsView()
}
