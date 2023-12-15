//
//  ContentView.swift
//  QuasarTerm
//
//  Created by daniel on 15/12/23.
//
import SwiftUI
import Defaults

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


#Preview {
    ContentView()
}
struct VisualEffectView: NSViewRepresentable {
    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()

        view.blendingMode = .behindWindow
        view.state = .active
        view.material = .underWindowBackground

        return view
    }

    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        //
    }
}
