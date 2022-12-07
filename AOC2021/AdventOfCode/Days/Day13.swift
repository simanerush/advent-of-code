//
//  Day13.swift
//  AdventOfCode
//

import Foundation

final class Day13: Day {
    
    struct Coordinate: Hashable {
        let x: Int
        let y: Int
    }
    
    func foldX(over val: Int, set: Set<Coordinate>) -> Set<Coordinate> {
        var folded: Set<Coordinate> = []
        for coord in set {
            if coord.x > val {
                assert(2*val - coord.x >= 0)
                folded.insert(Coordinate(x: 2*val - coord.x, y: coord.y))
            } else if coord.x < val {
                folded.insert(Coordinate(x: coord.x, y: coord.y))
            }
        }
        
        return folded
    }
    
    func foldY(over val: Int, set: Set<Coordinate>) -> Set<Coordinate> {
        var folded: Set<Coordinate> = []
        for coord in set {
            if coord.y > val {
                assert(2*val - coord.y >= 0)
                folded.insert(Coordinate(x: coord.x, y: 2*val - coord.y))
            } else if coord.y < val {
                folded.insert(Coordinate(x: coord.x, y: coord.y))
            }
        }
        
        return folded
    }
    
    func part1(_ input: String) -> CustomStringConvertible {
        let parsedInput = input
            .lines
        
        let point = parsedInput
            .firstIndex { line in
                line.starts(with: "f")
            }
        
        let coordinates = parsedInput[0..<point!]
            .map { coord -> (Int, Int) in
                let string = coord.split(separator: ",")
                return (Int(String(string[0]))!, Int(String(string[1]))!)
            }
        _ = parsedInput[point!..<parsedInput.count]
            .map { command -> (String, Int) in
                let string = command.split(separator: "=")
                return (String(string[0]), Int(String(string[1]))!)
            }
        
        var hashtagSet: Set<Coordinate> = []
        
        for coordinate in coordinates {
            hashtagSet.insert(Coordinate(x: coordinate.0, y: coordinate.1))
        }
        
        let folded = foldX(over: 655, set: hashtagSet)
        
        return folded.count
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let parsedInput = input
            .lines
        
        let point = parsedInput
            .firstIndex { line in
                line.starts(with: "f")
            }
        
        let coordinates = parsedInput[0..<point!]
            .map { coord -> (Int, Int) in
                let string = coord.split(separator: ",")
                return (Int(String(string[0]))!, Int(String(string[1]))!)
            }
        let commands = parsedInput[point!..<parsedInput.count]
            .map { command -> (String, Int) in
                let string = command.split(separator: "=")
                return (String(string[0]), Int(String(string[1]))!)
            }
        
        var hashtagSet: Set<Coordinate> = []
        
        for coordinate in coordinates {
            hashtagSet.insert(Coordinate(x: coordinate.0, y: coordinate.1))
        }
        
        var folded = foldX(over: 655, set: hashtagSet)
        for command in commands {
            if command.1 != 655 {
                if command.0 == "fold along x" {
                    folded = foldX(over: command.1, set: folded)
                } else if command.0 == "fold along y" {
                    folded = foldY(over: command.1, set: folded)
                }
            }
            
        }
        
        var display = Array(
            repeating: Array(
                repeating: ".",
                count: (folded.map({ $0.x }).max() ?? 0) + 1),
            count: (folded.map({ $0.y }).max() ?? 0) + 1
        )
        
        for coordinate in folded {
            display[coordinate.y][coordinate.x] = "#"
        }
        
        return "\n" +
        display
            .map { $0.joined(separator: "") }
            .joined(separator: "\n")
    }
}
