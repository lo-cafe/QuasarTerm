//
//  GeneralSettings.swift
//  QuasarTerm
//
//  Created by daniel on 10/02/24.
//

import SwiftUI
import Defaults

struct GeneralSettingsView: View {
    @Default(.shellProgram) var shellProgram
    @Default(.shellArguments) var shellArguments
    var body: some View {
        Form {
            Section {
                TextField("Program", text: $shellProgram)
                
                TextField("Arguments", text: Binding(get: {
                    return shellArguments.joined(separator: ",")
                }, set: { value in
                    shellArguments = value.split(separator: ",").map {$0.trimmingCharacters(in: .whitespacesAndNewlines) }
                }))
            }  header: {
                Text("Shell")
            } footer: {
                Text("Use commas to separate the arguments: arg1,arg2,arg3,...")
            }
        }
        .formStyle(.grouped)
    }
}

