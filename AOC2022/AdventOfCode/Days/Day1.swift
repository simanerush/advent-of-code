//
//  Day1.swift
//  AdventOfCode
//

import Foundation
import Algorithms

final class Day1: Day {
  
  func part1(_ input: String) -> CustomStringConvertible {
    return input
      .components(separatedBy: "\n\n")
      .map { line in
        line
          .ints
          .reduce(0, +)
      }
      .max()!
  }
  
  func part2(_ input: String) -> CustomStringConvertible {
    return input
      .components(separatedBy: "\n\n")
      .map { line in
        line
          .ints
          .reduce(0, +)
      }
      .max(count: 3)
      .reduce(0, +)
  }
}
