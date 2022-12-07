//
//  String+Helpers.swift
//  AdventOfCode
//
//  Created by Serafima Nerush on 12/3/21.
//

import Foundation

extension String {
    var lines: [Substring] {
        split(separator: "\n")
    }
    
    var ints: [Int] {
        lines.compactMap { Int($0) }
    }
}
