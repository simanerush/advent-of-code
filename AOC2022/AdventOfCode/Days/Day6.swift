//
//  Day6.swift
//  AdventOfCode
//

import Foundation

final class Day6: Day {
  func part1(_ input: String) -> CustomStringConvertible {
    findMarker(with: 4, input: input)
  }
  
  func part2(_ input: String) -> CustomStringConvertible {
    findMarker(with: 14, input: input)
  }
  
  func findMarker(with range: Int, input: String) -> Int {
    Array(input)
      .indexed()
      .windows(ofCount: range)
      .first { windowSlice in
        Set(windowSlice.map(\.element)).count == range
      }!
      .last!
      .index + 1
  }
}
