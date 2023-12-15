//
//  LocalProcessTerminalViewPrepresentable.swift
//  QuasarTerm
//
//  Created by daniel on 15/12/23.
//

import Foundation
import SwiftUI
import AppKit
import SwiftTerm
import Defaults

// Define the NSViewRepresentable for LocalProcessTerminalView
struct LocalProcessTerminalViewRepresentable: NSViewRepresentable {
    
    typealias NSViewType = LocalProcessTerminalView
    @Default(.terminalFont) var terminalFont
    @Default(.caretColor) var caretColor
    init(){
    }

    func makeNSView(context: Context) -> LocalProcessTerminalView {
        // MARK: - Terminal Setup
        let terminalView = LocalProcessTerminalView(frame: CGRect(x: 0, y: 0, width: 500, height: 500)) //random values
        let shell = getShell()
        let shellIdiom = "-" + NSString(string: shell).lastPathComponent
        FileManager.default.changeCurrentDirectoryPath (FileManager.default.homeDirectoryForCurrentUser.path)
        // MARK: - Terminal Appearance setup
        terminalView.startProcess(executable: shell, execName: shellIdiom)
        terminalView.nativeBackgroundColor = NSColor.clear
        terminalView.nativeForegroundColor = NSColor(Color(hex: 0xcad3f5))
        terminalView.layer?.backgroundColor = CGColor.clear
        // MARK: - Setting User Options
        terminalView.font = terminalFont
        terminalView.caretColor = NSColor(caretColor)
        
        // Hardcoded Terminal Colors for the moment
        let cols: [UInt8Color] = [
            .init(red: 73, green: 77, blue: 100),    // color0 - black
            .init(red: 237, green: 135, blue: 150),  // color1 - red
            .init(red: 166, green: 218, blue: 149),  // color2 - green
            .init(red: 238, green: 212, blue: 159),  // color3 - yellow
            .init(red: 138, green: 173, blue: 244),  // color4 - blue
            .init(red: 245, green: 189, blue: 230),  // color5 - magenta
            .init(red: 139, green: 213, blue: 202),  // color6 - cyan
            .init(red: 184, green: 192, blue: 224),  // color7 - white
            
            .init(red: 91, green: 96, blue: 120),    // color8 - bright black
            .init(red: 237, green: 135, blue: 150),  // color9 - bright red
            .init(red: 166, green: 218, blue: 149),  // color10 - bright green
            .init(red: 238, green: 212, blue: 159),  // color11 - bright yellow
            .init(red: 138, green: 173, blue: 244),  // color12 - bright blue
            .init(red: 245, green: 189, blue: 230),  // color13 - bright magenta
            .init(red: 139, green: 213, blue: 202),  // color14 - bright cyan
            .init(red: 165, green: 173, blue: 220),   // color15 - bright white
        ]
        
        terminalView.installColors(uint16ColorArray(cols))
        terminalView.caretTextColor = .black
        return terminalView
    }
    
    // Returns the shell associated with the current account
    func getShell () -> String
    {
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
        return String (cString: pwd.pw_shell)
    }

    func updateNSView(_ terminalView: LocalProcessTerminalView, context: Context) {
        // Update any properties if needed
    }
    
}
