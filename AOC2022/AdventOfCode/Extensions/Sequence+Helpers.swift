//
//  Sequence+Helpers.swift
//  AdventOfCode
//
//  Created by Serafima Nerush on 12/2/21.
//

import Foundation

extension Sequence where Element: Numeric {
    var sum: Element {
        return reduce(0, +)
    }
    
    var product: Element {
        return reduce(1, *)
    }
}

extension Sequence {
    func count(where: (Element) -> Bool) -> Int {
        return filter(`where`).count
    }
}
