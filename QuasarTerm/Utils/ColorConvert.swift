//
//  ColorConvert.swift
//  QuasarTerm
//
//  Created by daniel on 15/12/23.
//

import Foundation
import SwiftTerm

struct UInt8Color {
    var red: Int
    var green: Int
    var blue: Int
}

func uint16ColorArray(_ colors: [UInt8Color]) -> [SwiftTerm.Color] {
    var colorsArray: [SwiftTerm.Color] = []
    
    for color in colors {
        colorsArray.append(SwiftTerm.Color(
            red: bitshiftToUInt16(color.red),
            green: bitshiftToUInt16(color.green),
            blue: bitshiftToUInt16(color.blue)))
    }
    return colorsArray
}


private func bitshiftToUInt16(_ val: Int) -> UInt16 {
    return UInt16(val << 8)
}
