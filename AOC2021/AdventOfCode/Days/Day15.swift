//
//  Day15.swift
//  AdventOfCode
//

import Foundation

final class Day15: Day {
    
    struct Coordinate: Hashable {
        let x: Int
        let y: Int
    }
    
    func modifyGraph(_ graph: [[Int]]) -> [[Int]] {
        
        var newGraph = Array(
            repeating: Array(
                repeating: 0,
                count: (500)),
            count: (500))
        
        for i in 0..<500 {
            for j in 0..<500 {
                let newNum = graph[i % 100][j % 100] + i / 100 + j / 100
                if newNum > 9 {
                    newGraph[i][j] = newNum - 9
                } else {
                    newGraph[i][j] = newNum
                }
                
            }
        }
        return newGraph
    }
    
    func findNeighbors(point: Coordinate, height: Int, length: Int) -> [Coordinate] {
        var result: [Coordinate] = []
        
        if point.x != 0 {
            result.append(Coordinate(x: point.x - 1, y: point.y))
        }
        if point.y != 0 {
            result.append(Coordinate(x: point.x, y: point.y - 1))
        }
        if point.x != height - 1 {
            result.append(Coordinate(x: point.x + 1, y: point.y))
        }
        if point.y != length - 1 {
            result.append(Coordinate(x: point.x, y: point.y + 1))
        }
        
        return result
    }
    
    func dijkstra(graph: [[Int]]) -> Int {
        
        // (x, y, dist)
        var q = [(Coordinate(x: 0, y: 0), 0)]
        var costs: [Coordinate: Int] = [:]
        
        while let u = q.popLast() {
            if u.0.x == graph.count - 1 && u.0.y == graph[0].count - 1 {
                return u.1
            }
            let neighbors = findNeighbors(point: u.0, height: graph.count, length: graph[0].count)
            for neighbor in neighbors {
                let newCost = graph[neighbor.x][neighbor.y] + u.1
                if costs[neighbor] == nil || costs[neighbor]! > newCost {
                    q.append((neighbor, newCost))
                    costs[neighbor] = newCost
                }
            }
            q = q.sorted {
                $0.1 > $1.1
            }
        }
        
        return -1
    }
    
    func part1(_ input: String) -> CustomStringConvertible {
        let parsedInput = input
            .lines
            .map { line -> [Int] in
                var arr: [Int] = []
                for digit in line {
                    arr.append(Int(String(digit))!)
                }
                return arr
            }
        
        let result = dijkstra(graph: parsedInput)
        return result
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let parsedInput = input
            .lines
            .map { line -> [Int] in
                var arr: [Int] = []
                for digit in line {
                    arr.append(Int(String(digit))!)
                }
                return arr
            }
        
        
        let newarr = modifyGraph(parsedInput)
        let result = dijkstra(graph: newarr)
        return result
    }
}
