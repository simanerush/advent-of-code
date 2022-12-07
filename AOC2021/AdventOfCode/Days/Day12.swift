//
//  Day12.swift
//  AdventOfCode
//

import Foundation

final class Day12: Day {
    
    func findPoints(dict: [String: [String]], alreadyVisited: [String], start: String, visitedTwice: Bool = false) -> Int {
        var twice = false
        if start == "start" && alreadyVisited != [] {
            return 0
        }
        if start == "end" {
            return 1
        }
        if start.lowercased() == start && alreadyVisited.contains(start) && visitedTwice {
            return 0
            
        } else if start.lowercased() == start && alreadyVisited.contains(start) {
            twice = true
        }
        var result = 0
        for value in dict[start]! {
            result += findPoints(dict: dict, alreadyVisited: alreadyVisited + [start], start: value, visitedTwice: visitedTwice || twice)
        }
        return result
    }
    
    func part1(_ input: String) -> CustomStringConvertible {
        var graph: [String: [String]] = [:]
        input
            .lines
            .map { line in line.split(separator: "-") }
            .forEach { pair in
                if graph[String(pair[0])] != nil{
                    graph[String(pair[0])]!.append(String(pair[1]))
                } else {
                    graph[String(pair[0])] = [String(pair[1])]
                }
                if graph[String(pair[1])] != nil{
                    graph[String(pair[1])]!.append(String(pair[0]))
                } else {
                    graph[String(pair[1])] = [String(pair[0])]
                }
            }
        
        return findPoints(dict: graph, alreadyVisited: [], start: "start", visitedTwice: true)
    }

    func part2(_ input: String) -> CustomStringConvertible {
        var graph: [String: [String]] = [:]
        input
            .lines
            .map { line in line.split(separator: "-") }
            .forEach { pair in
                if graph[String(pair[0])] != nil{
                    graph[String(pair[0])]!.append(String(pair[1]))
                } else {
                    graph[String(pair[0])] = [String(pair[1])]
                }
                if graph[String(pair[1])] != nil{
                    graph[String(pair[1])]!.append(String(pair[0]))
                } else {
                    graph[String(pair[1])] = [String(pair[0])]
                }
            }
        
        return findPoints(dict: graph, alreadyVisited: [], start: "start")
    }
}
