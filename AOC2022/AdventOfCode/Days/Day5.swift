//
//  Day5.swift
//  AdventOfCode
//

import Foundation
import RegexBuilder

final class Day5: Day {
  func part1(_ input: String) -> CustomStringConvertible {
    let parts = input.components(separatedBy: "\n\n")
    var stacks = parseStacks(from: parts[0])
    let instructions = parseInstructions(from: parts[1])
    
    for (stackNumber, from, to) in instructions {
      for _ in 1...stackNumber {
        let val = stacks[from]!.popLast()!
        stacks[to]?.append(val)
      }
    }
    
    return stacks
      .keys
      .sorted()
      .map { String(stacks[$0]!.last!) }
      .joined()
  }
  
  func part2(_ input: String) -> CustomStringConvertible {
    let parts = input.components(separatedBy: "\n\n")
    var stacks = parseStacks(from: parts[0])
    let instructions = parseInstructions(from: parts[1])
    
    for (stackNumber, from, to) in instructions {
      var values = Array<Character>()
      for _ in 1...stackNumber {
        values.append(stacks[from]!.popLast()!)
      }
      
      for value in values.reversed() {
        stacks[to]?.append(value)
      }
    }
    
    return stacks
      .keys
      .sorted()
      .map { String(stacks[$0]!.last!) }
      .joined()
  }
  
  func parseStacks(from input: String) -> Dictionary<Int, Array<Character>> {
    input
      .lines
      .reduce(into: Dictionary<Int, Array<Character>>()) { stacks, line in
        for (i, char) in line.enumerated() {
          guard char.isLetter else { continue }
          stacks[(i / 4) + 1, default: []].insert(char, at: 0)
        }
      }
  }
  
  func parseInstructions(from input: String) -> [(stackNumber: Int, from: Int, to: Int)] {
    input
      .lines
      .map { line in
        let numbers = Capture { OneOrMore(.digit) } transform: { Int($0)! }
        
        let lineParser = Regex {
          "move "
          numbers
          " from "
          numbers
          " to "
          numbers
        }
        
        let match = try! lineParser.wholeMatch(in: line)!.output
        return (match.1, match.2, match.3)
      }
  }
}
