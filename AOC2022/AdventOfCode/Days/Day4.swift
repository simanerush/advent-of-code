//
//  Day4.swift
//  AdventOfCode
//

import Foundation

final class Day4: Day {
  func part1(_ input: String) -> CustomStringConvertible {
    input
      .lines
      .map(parse)
      .filter { $0.0.contains($0.1) || $0.1.contains($0.0) }
      .count
  }
  
  func parse(_ line: Substring) -> (ClosedRange<Int>, ClosedRange<Int>) {
    let numbers = line.split(whereSeparator: { $0.isNumber == false }).map { Int($0)! }
    return (numbers[0] ... numbers[1], numbers[2] ... numbers[3])
  }
  
  func part2(_ input: String) -> CustomStringConvertible {
    input
      .lines
      .map(parse)
      .filter { $0.0.overlaps($0.1) || $0.1.overlaps($0.0) }
      .count
  }
}
