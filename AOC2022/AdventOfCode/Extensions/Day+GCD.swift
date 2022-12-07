//
//  Day+GCD.swift
//  AdventOfCode
//
//  Created by Serafima Nerush on 12/5/21.
//

import Foundation

extension Day {
    func gcd(_ a: Int, _ b: Int) -> Int {
        if b == 0 {
            return a
        }
        let r = a % b
        if r != 0 {
            return gcd(b, r)
        } else {
            return b
        }
    }
}
