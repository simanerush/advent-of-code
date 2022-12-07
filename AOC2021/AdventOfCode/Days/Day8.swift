//
//  Day8.swift
//  AdventOfCode
//

import Foundation

final class Day8: Day {
    func part1(_ input: String) -> CustomStringConvertible {
        return input
            .lines
            .flatMap { line in line.split(separator: "|").last!.split(separator: " ") }
            .count { string in
                [2, 4, 3, 7].contains(string.count)
            }
        
    }
    
    func sortByLength(_ strings: [Substring]) -> [[String]] {
        
        var result: [[String]] = Array(repeating: [], count: 8)
        
        for string in strings {
            result[string.count].append(String(string))
        }
        
        return result
    }
    
    func decode(_ values: [[String]]) -> Dictionary<Character, Character> {
        
        var dict: Dictionary<Character, Character>  = [:]
        
        if values[3] != [] {
            for chr in values[3][0] {
                if values[2] != [] {
                    if !values[2][0].contains(chr) {
                        dict[chr] = "a"
                        break
                    }
                }
            }
        }
        
        if values[4] != [] {
            for chr in values[4][0] {
                if values[2] != [] {
                    if !values[2][0].contains(chr) && (countContains(in: values[5], for: chr) == 1) {
                        dict[chr] = "b"
                        break
                    }
                }
            }
        }
        
        if values[4] != [] {
            for chr in values[4][0] {
                if values[2] != [] {
                    if !values[2][0].contains(chr) && dict[chr] != "b" {
                        dict[chr] = "d"
                        break
                    }
                }
            }
        }
        
        if values[2] != [] {
            for chr in values[2][0] {
                if countContains(in: values[6], for: chr) == 2 {
                    dict[chr] = "c"
                    break
                }
            }
        }
        
        if values[2] != [] {
            for chr in values[2][0] {
                if dict[chr] != "c" {
                    dict[chr] = "f"
                    break
                }
            }
        }
        
        if values[5] != [] {
            for chr in values[5][0] {
                if (countContains(in: values[6], for: chr) == 3) && (dict[chr] != "a") && (dict[chr] != "b") && (dict[chr] != "f") {
                    dict[chr] = "g"
                    break
                }
            }
        }
        
        if values[7] != [] {
            for chr in values[7][0] {
                if (dict[chr] != "a") && (dict[chr] != "b") && (dict[chr] != "c") && (dict[chr] != "d") && (dict[chr] != "f") && (dict[chr] != "g") {
                    dict[chr] = "e"
                    break
                }
            }
        }
        
        return dict
    }
    
    func countContains(in stringList: [String], for character: Character) -> Int {
    
        return stringList.count {
            $0.contains(character)
        }
    }
    
    func part2(_ input: String) -> CustomStringConvertible {
        
        let digitsEncoding = ["abcefg", "cf", "acdeg", "acdfg", "bcdf", "abdfg", "abdefg", "acf", "abcdefg", "abcdfg"]
        
        var inputStrings = input
            .lines
            .map { line in
                line.split(separator: "|").map { line in
                    line.split(separator: " ")
                }
            }
        
        var sums: [Int] = []
        
        for i in 0...inputStrings.count - 1 {
            let sorted = sortByLength(inputStrings[i][0])
            let dict = decode(sorted)
        
            var decodedDigits: String = ""
            
            for string in inputStrings[i][1] {
                var newString: String = ""
                for chr in string {
                    newString.append(dict[chr]!)
                }
                newString = String(newString.sorted())
                decodedDigits.append(String(digitsEncoding.firstIndex(of: newString)!))
            }
            
            sums.append(Int(decodedDigits)!)
        }
        return sums.sum
    }
}
