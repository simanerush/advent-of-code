//
//  Day9.swift
//  AdventOfCode
//

import Foundation

final class Day9: Day {
    
    func findLowPoints(inputParsed: [[Int]]) -> [Int] {
        var lowPoints: [Int] = []
        for i in 0...inputParsed.count - 1 {
            for j in 0...inputParsed.count - 1 {
                if i != 0 && i != inputParsed.count - 1 && j != 0 && j != inputParsed.count - 1 {
                    if inputParsed[i][j] < inputParsed[i-1][j] && inputParsed[i][j] < inputParsed[i+1][j] && inputParsed[i][j] < inputParsed[i][j - 1] && inputParsed[i][j] < inputParsed[i][j + 1] {
                        lowPoints.append(inputParsed[i][j] + 1)
                    }
                } else if i == 0 && j != 0 && j != inputParsed.count - 1 {
                    if inputParsed[i][j] < inputParsed[i+1][j] && inputParsed[i][j] < inputParsed[i][j - 1] && inputParsed[i][j] < inputParsed[i][j + 1] {
                        lowPoints.append(inputParsed[i][j] + 1)
                    }
                } else if i == inputParsed.count - 1 && j != 0 && j != inputParsed.count - 1 {
                    if inputParsed[i][j] < inputParsed[i-1][j] && inputParsed[i][j] < inputParsed[i][j - 1] && inputParsed[i][j] < inputParsed[i][j + 1] {
                        lowPoints.append(inputParsed[i][j] + 1)
                    }
                } else if i != 0 && i != inputParsed.count - 1 && j == 0 {
                    if inputParsed[i][j] < inputParsed[i-1][j] && inputParsed[i][j] < inputParsed[i][j + 1] && inputParsed[i][j] < inputParsed[i + 1][j] {
                        lowPoints.append(inputParsed[i][j] + 1)
                    }
                } else if i != 0 && i != inputParsed.count - 1 && j == inputParsed.count - 1 {
                    if inputParsed[i][j] < inputParsed[i-1][j] && inputParsed[i][j] < inputParsed[i+1][j] && inputParsed[i][j] < inputParsed[i][j - 1] {
                        lowPoints.append(inputParsed[i][j] + 1)
                    }
                } else if i == 0 && j == 0 {
                    if inputParsed[i][j] < inputParsed[i+1][j] && inputParsed[i][j] < inputParsed[i][j + 1] {
                        lowPoints.append(inputParsed[i][j] + 1)
                    }
                } else if i == inputParsed.count - 1 && j == inputParsed.count - 1 {
                    if inputParsed[i][j] < inputParsed[i-1][j] && inputParsed[i][j] < inputParsed[i][j - 1] {
                        lowPoints.append(inputParsed[i][j] + 1)
                    }
                }  else if i == inputParsed.count - 1 && j == 0 {
                    if inputParsed[i][j] < inputParsed[i-1][j] && inputParsed[i][j] < inputParsed[i][j + 1] {
                        lowPoints.append(inputParsed[i][j] + 1)
                    }
                } else if i == 0 && j == inputParsed.count - 1{
                    if inputParsed[i][j] < inputParsed[i+1][j] && inputParsed[i][j] < inputParsed[i][j - 1] {
                        lowPoints.append(inputParsed[i][j] + 1)
                    }
                }
            }
        }
        return lowPoints
    }
    
    func findNeighbors(point: (Int, Int), height: Int, length: Int) -> [(Int, Int)] {
        var result: [(Int, Int)] = []
        
        if point.0 != 0 {
            result.append((point.0 - 1, point.1))
        }
        if point.1 != 0 {
            result.append((point.0, point.1 - 1))
        }
        if point.0 != height - 1 {
            result.append((point.0 + 1, point.1))
        }
        if point.1 != length - 1 {
            result.append((point.0, point.1 + 1))
        }
        
        return result
    }
    
    func part1(_ input: String) -> CustomStringConvertible {
        let inputParsed = input
            .lines
            .map {
                line in line.map{$0.wholeNumberValue!}
            }
        
        return findLowPoints(inputParsed: inputParsed).sum
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let inputParsed = input
            .lines
            .map {
                line in line.map{$0.wholeNumberValue!}
            }
        
        var checkedNeighbors: Array<(Int, Int)> = []
        
        var allLengths: [Int] = []
        
        for i in 0...inputParsed.count - 1 {
            for j in 0...inputParsed.count - 1 {
                var count = 1
                var toFind: Array<(Int, Int)> = []
                if checkedNeighbors.contains{ pair in
                    i == pair.0 && j == pair.1
                } {
                    continue
                }
                checkedNeighbors.append((i, j))
                let neighbors = findNeighbors(point: (i, j), height: inputParsed.count, length: inputParsed[0].count)
                for coordinates in neighbors {
                    if !checkedNeighbors.contains{ pair in
                        coordinates.0 == pair.0 && coordinates.1 == pair.1
                    } {
                        checkedNeighbors.append(coordinates)
                        if inputParsed[coordinates.0][coordinates.1] != 9 {
                            toFind.append(coordinates)
                        }
                    }
                }
                while !toFind.isEmpty {
                    let last = toFind.popLast()!
                    if inputParsed[last.0][last.1] != 9 {
                        count += 1
                        let neighbors = findNeighbors(point: last, height: inputParsed.count, length: inputParsed[0].count)
                        for coordinates in neighbors {
                            if !checkedNeighbors.contains{ pair in
                                coordinates.0 == pair.0 && coordinates.1 == pair.1
                            } {
                                if inputParsed[coordinates.0][coordinates.1] != 9 {
                                    toFind.append(coordinates)
                                }
                                checkedNeighbors.append(coordinates)
                            }
                        }
                    }
                }
                
                allLengths.append(count)

            }
        }
        
        let sort = allLengths.sorted()
        let result = sort[sort.count - 1 ] * sort[sort.count - 2 ] * sort[sort.count - 3]
        return result
    }
}
