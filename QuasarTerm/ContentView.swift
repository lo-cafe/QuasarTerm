//
//  ContentView.swift
//  QuasarTerm
//
//  Created by daniel on 15/12/23.
//
import Defaults
import SwiftUI

struct ContentView: View {
    @Default(.backroundTint) var backgroundTint
    var body: some View {
        VStack {
            LocalProcessTerminalViewRepresentable()
                .background(.clear)
                .padding(.top, 5)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundTint)
        .background(VisualEffectView().ignoresSafeArea())
        .preferredColorScheme(.dark)
        .navigationTitle("Quasar")
    }
}

struct VisualEffectView: NSViewRepresentable {
    func makeNSView(context _: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()

        view.blendingMode = .behindWindow
        view.state = .active
        view.material = .underWindowBackground

        return view
    }

    func updateNSView(_: NSVisualEffectView, context _: Context) {
        //
    }
}
