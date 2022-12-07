//
//  Day14.swift
//  AdventOfCode
//

import Foundation

final class Day14: Day {
    
    func step(_ line: String, dict: [String: String]) -> String {
        var newLine = ""
        
        for i in line.indices {
            let end = line.index(i, offsetBy: 2)
            var pair = String(line[i..<end])
            if let val = dict[pair] {
                pair.removeLast()
                pair.append(val)
                newLine.append(pair)
                
            }
            if end == line.endIndex {
                newLine.append(line.last!)
                break
            }
        }
        
        return newLine
    }
    
    func step2(_ pairDict: [String: Int], dict: [String: String], charDict: inout [Character: Int]) -> Dictionary<String, Int> {
        
        var newPairDict: [String: Int] = [:]
        for (pair, count) in pairDict {
            newPairDict["\(pair.first!)\(dict[pair]!)"] = (newPairDict["\(pair.first!)\(dict[pair]!)"] ?? 0) + count
            newPairDict["\(dict[pair]!)\(pair.last!)"] = (newPairDict["\(dict[pair]!)\(pair.last!)"] ?? 0) + count
            charDict[dict[pair]!.first!] =  (charDict[dict[pair]!.first!] ?? 0) + count
        }
        
        return newPairDict
    }

    
    func part1(_ input: String) -> CustomStringConvertible {
        var parsedInput = input
            .lines
        
        let line = String(parsedInput[0])
        
        parsedInput.remove(at: 0)
        
        var dict: [String: String] = [:]
        for pair in parsedInput {
            dict[String(pair.prefix(2))] = String(pair.last!)
    
        }
        
        var result = line
        
        var charDict: [Character: Int] = [:]
        
        for i in 0..<10 {
            result = step(result, dict: dict)
        }
        
        for char in result {
            charDict[char] = (charDict[char] ?? 0) + 1
        }
        
        var max = Int.min
        var min = Int.max
        
        for (key, value) in charDict {
            if value < min {
                min = value
            }
            if value > max {
                max = value
            }
        }
        
        return max - min
    }

    func part2(_ input: String) -> CustomStringConvertible {
        var parsedInput = input
            .lines
        
        let line = String(parsedInput[0])
        
        parsedInput.remove(at: 0)
        
        var dict: [String: String] = [:]
        for pair in parsedInput {
            dict[String(pair.prefix(2))] = String(pair.last!)
            
        }
        
        var charDict: [Character: Int] = [:]
        var pairDict: [String: Int] = [:]
        
        for char in line {
            charDict[char] = (charDict[char] ?? 0) + 1
        }
        
        for i in line.indices {
            let end = line.index(i, offsetBy: 2)
            var pair = String(line[i..<end])
            pairDict[pair] = (pairDict[pair] ?? 0) + 1
            if end == line.endIndex {
                break
            }
        }
        
        for i in 0..<40 {
            pairDict = step2(pairDict, dict: dict, charDict: &charDict)
        }
        
        
        
        var max = Int.min
        var min = Int.max
        
        for (key, value) in charDict {
            if value < min {
                min = value
            }
            if value > max {
                max = value
            }
        }
        
        return max - min
    }
}
