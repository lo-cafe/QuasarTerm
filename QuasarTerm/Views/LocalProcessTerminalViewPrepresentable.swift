//
//  LocalProcessTerminalViewPrepresentable.swift
//  QuasarTerm
//
//  Created by daniel on 15/12/23.
//

import AppKit
import Defaults
import Foundation
import SwiftTerm
import SwiftUI

// Define the NSViewRepresentable for LocalProcessTerminalView
struct LocalProcessTerminalViewRepresentable: NSViewRepresentable {
    typealias NSViewType = LocalProcessTerminalView
    @Default(.terminalFont) var terminalFont
    @Default(.caretColor) var caretColor
    @Binding var ansiColors: [String]
    init(ansiColors: Binding<[String]>) {
        _ansiColors = ansiColors
    }

    func makeNSView(context _: Context) -> LocalProcessTerminalView {
        // MARK: - Terminal Setup

        let terminalView = LocalProcessTerminalView(frame: CGRect(x: 0, y: 0, width: 500, height: 500)) // random values
        let shell = getShell()
        let shellIdiom = "-" + NSString(string: shell).lastPathComponent
        FileManager.default.changeCurrentDirectoryPath(FileManager.default.homeDirectoryForCurrentUser.path)

        // MARK: - Terminal Appearance setup

        terminalView.startProcess(executable: shell,args: Defaults[.shellArguments], execName: shellIdiom)
        terminalView.nativeBackgroundColor = NSColor.clear
        terminalView.nativeForegroundColor = NSColor(Color(hex: 0xCAD3F5))
        terminalView.layer?.backgroundColor = CGColor.clear

        // MARK: - Setting User Options

        terminalView.font = terminalFont
        terminalView.caretColor = NSColor(caretColor)

        // Hardcoded Terminal Colors for the moment
        terminalView.installColors(loadansiColors(ansiColors: ansiColors))
        terminalView.caretTextColor = .black

        return terminalView
    }

    // Returns the shell associated with the current account
    func getShell() -> String {
        @Default(.shellProgram) var shellProgram
        let bufsize = sysconf(_SC_GETPW_R_SIZE_MAX)
        guard bufsize != -1 else {
            return "/bin/bash"
        }
        let buffer = UnsafeMutablePointer<Int8>.allocate(capacity: bufsize)
        defer {
            buffer.deallocate()
        }
        var pwd = passwd()
        var result: UnsafeMutablePointer<passwd>? = UnsafeMutablePointer<passwd>.allocate(capacity: 1)

        if getpwuid_r(getuid(), &pwd, buffer, bufsize, &result) != 0 {
            return "/bin/bash"
        }
        return shellProgram != "" ? shellProgram : String(cString: pwd.pw_shell)
    }

    func updateNSView(_: LocalProcessTerminalView, context _: Context) {
        // Update any properties if needed
    }
}
