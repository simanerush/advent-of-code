//
//  Day6.swift
//  AdventOfCode
//

import Foundation

final class Day6: Day {
    func simulate(_ count: inout [Int]) {
        let zeroAge = count[0]
        
        for i in 1...8 {
            count[i - 1] = count[i]
        }
        
        count[8] = zeroAge
        count[6] += zeroAge
    }
    
    func part1(_ input: String) -> CustomStringConvertible {
        var ageCount = Array(repeating: 0, count: 9)
        input
            .lines
            .first!
            .split(separator: ",")
            .compactMap { Int($0) }
            .forEach {
                ageCount[$0] += 1
            }
        
        for _ in 1...80 {
            simulate(&ageCount)
        }
        
        return ageCount.sum
    }

    func part2(_ input: String) -> CustomStringConvertible {
        var ageCount = Array(repeating: 0, count: 9)
        input
            .lines
            .first!
            .split(separator: ",")
            .compactMap { Int($0) }
            .forEach {
                ageCount[$0] += 1
            }
        
        for _ in 1...256 {
            simulate(&ageCount)
        }
        
        return ageCount.sum
    }
}
