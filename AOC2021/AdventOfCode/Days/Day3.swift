//
//  Day3.swift
//  AdventOfCode
//

import Foundation

final class Day3: Day {
    
    func bitCounts(_ array: [UInt]) -> [Int] {
        // Initialize an array of 12 zeroes
        var counts = Array(repeating: 0, count: 12)
        for num in array {
            // Current number
            var num = num
            for i in 0..<12 {
                if num & 1 != 0 {
                    counts[i] += 1
                }
                num = num >> 1
            }
        }
        return counts
    }

    func part1(_ input: String) -> CustomStringConvertible {
        var gamma = UInt()
        
        // Convert every line to UInt
        let nums = input.lines.compactMap { UInt($0, radix: 2) }
        // In every line, count the number of each bit
        let counts = bitCounts(nums)
        
        let half = nums.count / 2
        for i in (0..<12).reversed() {
            gamma = gamma << 1
            if counts[i] > half {
                gamma = gamma | 1
            }
        }
        
        return gamma * (~gamma & 0b111111111111)
    }
        

    func part2(_ input: String) -> CustomStringConvertible {
        // Convert every line to UInt
        let nums = input.lines.compactMap { UInt($0, radix: 2) }
        
        var oxygenNums = nums
        var scrubberNums = nums
        
        for i in (0..<12).reversed() {
            if oxygenNums.count == 1 && scrubberNums.count == 1 {
                break
            }
            if oxygenNums.count > 1 {
                let oxygenCounts = bitCounts(oxygenNums)
                let oxygenHalf = Int(ceil(Double(oxygenNums.count) / 2.0))
                oxygenNums = oxygenNums.filter { num in
                    ((num >> i) & 1) == (oxygenCounts[i] >= oxygenHalf ? 1 : 0)
                }
            }
            if scrubberNums.count > 1 {
                let scrubberCounts = bitCounts(scrubberNums)
                let scrubberHalf = Int(ceil(Double(scrubberNums.count) / 2.0))
                scrubberNums = scrubberNums.filter { num in
                    return ((num >> i) & 1) == (scrubberCounts[i] >= scrubberHalf ? 0 : 1)
                }
            }
        }
        return oxygenNums.first! * scrubberNums.first!
    }
}
