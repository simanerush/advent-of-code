//
//  Day8.swift
//  AdventOfCode
//

import Foundation

final class Day8: Day {
  
  struct Tree: Hashable {
    var x: Int
    var y: Int
    
    func isVisible(allTrees: [Tree:Int], height: Int, xCount: Int, yCount: Int) -> Bool {
      guard x != 0 && y != 0 && x != xCount - 1 && y != yCount - 1 else {
        return true
      }
      
      if (0..<x).allSatisfy({ allTrees[Tree(x: $0, y: y)]! < height }) { return true }
      if (x + 1..<xCount).allSatisfy({ allTrees[Tree(x: $0, y: y)]! < height }) { return true }
      if (0..<y).allSatisfy({ allTrees[Tree(x: x, y: $0)]! < height }) { return true }
      if (y + 1..<yCount).allSatisfy({ allTrees[Tree(x: x, y: $0)]! < height }) { return true }
      
      return false
    }
    
    func scenicScore(allTrees: [Tree:Int], height: Int, xCount: Int, yCount: Int) -> Int {
      guard x != 0 && y != 0 && x != xCount - 1 && y != yCount - 1 else {
        return 0
      }
      
      var score = 1
      
      func visibility(for points: [Tree]) -> Int {
        var visibility = 0
        for point in points {
          visibility += 1
          if allTrees[point]! >= height {
            return visibility
          }
        }
        return visibility
      }
      
      score *= visibility(for: (0..<x).reversed().map { Tree(x: $0, y: y) })
      score *= visibility(for: (x + 1..<xCount).map { Tree(x: $0, y: y) })
      score *= visibility(for: (0..<y).reversed().map { Tree(x: x, y: $0) })
      score *= visibility(for: (y + 1..<yCount).map { Tree(x: x, y: $0) })
      
      return score
    }
  }
  
  func part1(_ input: String) -> CustomStringConvertible {
    let xCount = input.lines.first!.count
    let yCount = input.lines.count
    
    let trees = input
      .lines
      .enumerated()
      .reduce(into: [Tree:Int]()) { dict, tuple in
        let (y, line) = tuple
				line.enumerated().forEach { x, c in
					dict[Tree(x: x, y: y)] = c.wholeNumberValue!
				}
      }
    
    return trees
      .filter { tree, height in
        tree.isVisible(allTrees: trees, height: height, xCount: xCount, yCount: yCount)
      }
      .count
  }
  
  func part2(_ input: String) -> CustomStringConvertible {
    let xCount = input.lines.first!.count
    let yCount = input.lines.count
    
    let trees = input
      .lines
      .enumerated()
      .reduce(into: [Tree:Int]()) { dict, tuple in
        let (y, line) = tuple
        line.enumerated().forEach { x, c in
          dict[Tree(x: x, y: y)] = c.wholeNumberValue!
        }
      }
    
    return trees
      .map { tree, height in
        tree.scenicScore(allTrees: trees, height: height, xCount: xCount, yCount: yCount)
      }
      .max()!
  }
}
