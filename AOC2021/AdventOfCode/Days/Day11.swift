//
//  Day11.swift
//  AdventOfCode
//

import Foundation

final class Day11: Day {
    
    func simulate(_ points: inout [[Int]]) {
        for i in 0...points.count - 1 {
            for j in 0...points.count - 1 {
                points[i][j] += 1
            }
        }
    }
    
    func flashes(points: inout [[Int]], excluded: [(Int, Int)]) -> Int{
        var flashesCount = 0
        var excludedPoints: [(Int, Int)] = []
        for i in 0...points.count - 1 {
            for j in 0...points.count - 1 {
                if points[i][j] >= 10 && !excluded.contains(where: { pair in
                    i == pair.0 && j == pair.1
                }) {
                    points[i][j] = 0
                    flashesCount += 1
                    excludedPoints.append((i, j))
                    let neighbors = findNeighbors(point: (i, j), height: points.count, length: points[0].count)
                    for (i, j) in neighbors {
                        if !excluded.contains(where: { pair in
                            i == pair.0 && j == pair.1
                        }) && !excludedPoints.contains(where: { pair in
                            i == pair.0 && j == pair.1
                        }) {
                            points[i][j] += 1
                        }
                    }
                }
            }
        }
        
        if flashesCount == 0 {
            return 0
        } else {
            return flashesCount + flashes(points: &points, excluded: excluded + excludedPoints)
        }
    }
    
    func findNeighbors(point: (Int, Int), height: Int, length: Int) -> [(Int, Int)] {
        var result: [(Int, Int)] = []
        
        if point.0 != 0 {
            result.append((point.0 - 1, point.1))
            if point.1 != 0 {
                result.append((point.0 - 1, point.1 - 1))
            }
            if point.1 != height - 1 {
                result.append((point.0 - 1, point.1 + 1))
            }
        }
        if point.1 != 0 {
            result.append((point.0, point.1 - 1))
        }
        if point.0 != height - 1 {
            result.append((point.0 + 1, point.1))
            if point.1 != 0 {
                result.append((point.0 + 1, point.1 - 1))
            }
            if point.1 != height - 1 {
                result.append((point.0 + 1, point.1 + 1))
            }
        }
        if point.1 != length - 1 {
            result.append((point.0, point.1 + 1))
        }
        
        
        return result
    }
    
    func part1(_ input: String) -> CustomStringConvertible {
        var inputParsed = input
            .lines
            .map {
                line in line.map{$0.wholeNumberValue!}
            }
        
        var flashesCount = 0
        for _ in 0..<100 {
            simulate(&inputParsed)
            let flashes = flashes(points: &inputParsed, excluded: [])
            print(flashes)
            flashesCount += flashes
        }

        return flashesCount
    }

    func part2(_ input: String) -> CustomStringConvertible {
        var inputParsed = input
            .lines
            .map {
                line in line.map{$0.wholeNumberValue!}
            }
        
        var flashesCount = 0
        var step = 0
        while true {
            simulate(&inputParsed)
            let flashes = flashes(points: &inputParsed, excluded: [])
            print(flashes)
            flashesCount += flashes
            if flashes == 100 {
                return step + 1
            }
            step += 1
        }
        
        return -1
    }
}
