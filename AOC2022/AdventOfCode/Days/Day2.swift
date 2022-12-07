//
//  Day2.swift
//  AdventOfCode
//

import Foundation

final class Day2: Day {
  func part1(_ input: String) -> CustomStringConvertible {
    let lines = input.lines
    var sum = 0
    for line in lines {
      let choices = line.components(separatedBy: " ")
      switch choices[0] {
      case "A":
        switch choices[1] {
        case "X":
          sum += 1
          sum += 3
        case "Y":
          sum += 2
          sum += 6
        case "Z":
          sum += 3
          sum += 0
        default:
          return 0
        }
      case "B":
        switch choices[1] {
        case "X":
          sum += 1
          sum += 0
        case "Y":
          sum += 2
          sum += 3
        case "Z":
          sum += 3
          sum += 6
        default:
          return 0
        }
      case "C":
        switch choices[1] {
        case "X":
          sum += 1
          sum += 6
        case "Y":
          sum += 2
          sum += 0
        case "Z":
          sum += 3
          sum += 3
        default:
          return 0
        }
      default: return 0
      }
    }
    return sum
  }
  
  func part2(_ input: String) -> CustomStringConvertible {
    let lines = input.lines
    var sum = 0
    for line in lines {
      let choices = line.components(separatedBy: " ")
      switch choices[0] {
      case "A":
        switch choices[1] {
        case "X":
          sum += 3
          sum += 0
        case "Y":
          sum += 1
          sum += 3
        case "Z":
          sum += 2
          sum += 6
        default:
          return 0
        }
      case "B":
        switch choices[1] {
        case "X":
          sum += 1
          sum += 0
        case "Y":
          sum += 2
          sum += 3
        case "Z":
          sum += 3
          sum += 6
        default:
          return 0
        }
      case "C":
        switch choices[1] {
        case "X":
          sum += 2
          sum += 0
        case "Y":
          sum += 3
          sum += 3
        case "Z":
          sum += 1
          sum += 6
        default:
          return 0
        }
      default: return 0
      }
    }
    return sum
  }
}
