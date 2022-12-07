//
//  Day5.swift
//  AdventOfCode
//

import Foundation

final class Day5: Day {
    func part1(_ input: String) -> CustomStringConvertible {
        var intersections = [String: Int]()
        input
            .lines
            .forEach { line in
                let components = line
                    .components(separatedBy: " -> ")
                    .map { component -> (Int, Int) in
                        let nums = component
                            .split(separator: ",")
                            .compactMap { Int($0) }
                        return (nums.first!, nums.last!)
                    }
                
                // Get starting and ending points
                let (start, end) = (components[0], components[1])
                
                // Horizontal line
                if start.0 == end.0 {
                    for y in min(start.1, end.1)...max(start.1, end.1) {
                        let key = "\(start.0),\(y)"
                        intersections[key] = (intersections[key] ?? 0) + 1
                    }
                }
                
                // Vertical line
                if start.1 == end.1 {
                    for x in min(start.0, end.0)...max(start.0, end.0) {
                        let key = "\(x),\(start.1)"
                        intersections[key] = (intersections[key] ?? 0) + 1
                    }
                }
                
            }
        return intersections.count { $0.value > 1 }
    }

    func part2(_ input: String) -> CustomStringConvertible {
        var intersections = [String: Int]()
        input
            .lines
            .forEach { line in
                let components = line
                    .components(separatedBy: " -> ")
                    .map { component -> (Int, Int) in
                        let nums = component
                            .split(separator: ",")
                            .compactMap { Int($0) }
                        return (nums.first!, nums.last!)
                    }
                
                let (start, end) = (components[0], components[1])
                
                // Change in y and change in x
                let delx = end.0 - start.0
                let dely = end.1 - start.1
                
                let commonDenominator = gcd(abs(delx), abs(dely))
                //print("got gcd of \(commonDenominator)")
                
                var current = start
                
                let key = "\(start.0),\(start.1)"
                intersections[key] = (intersections[key] ?? 0) + 1
                
                let yslope = dely / commonDenominator
                let xslope = delx / commonDenominator
                
                while current != end {
                    current.0 += xslope
                    current.1 += yslope
                    
                    let key = "\(current.0),\(current.1)"
                    intersections[key] = (intersections[key] ?? 0) + 1
                }
                
                
            }
        return intersections.count { $0.value > 1 }
    }
}
