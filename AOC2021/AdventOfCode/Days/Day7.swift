//
//  Day7.swift
//  AdventOfCode
//

import Foundation

final class Day7: Day {
    
    func calculateDistanceWithRate(distance: Int) -> Int {
        var steps = [Int](repeating: 1, count: distance)
        var rate = 0
        
        if steps.count == 1 {
            return 1
        }
        else if steps.count != 0 {
            for i in 0...steps.count - 1 {
                steps[i] += rate
                rate += 1
            }
        }
        
        return steps.sum
    }
    
    func calculateFuel(array: [Int], position: Int) -> Int {
        var fuelUsed = 0
        for i in 0...array.count - 1 {
            fuelUsed += abs(array[i].distance(to: position))
        }
        
        return fuelUsed
    }
    
    func calculateFuelWithRate(array: [Int], position: Int) -> Int {
        var fuelUsed = 0
        for i in 0...array.count - 1 {
            let distance = abs(array[i].distance(to: position))
            fuelUsed += calculateDistanceWithRate(distance: distance)
        }
        
        return fuelUsed
    }
    
    func part1(_ input: String) -> CustomStringConvertible {
        
        var cheapest = Int.max
        
        let inputArray = input
            .lines
            .first!
            .split(separator: ",")
            .compactMap { Int($0) }
        
        for position in inputArray {
            let currentPrice = calculateFuel(array: inputArray, position: position)
            if  currentPrice < cheapest {
                cheapest = currentPrice
            }
        }
        
        return cheapest
    }

    func part2(_ input: String) -> CustomStringConvertible {
        var cheapest = Int.max
        
        let inputArray = input
            .lines
            .first!
            .split(separator: ",")
            .compactMap { Int($0) }

        
        for i in 0...inputArray.max()! {
            let currentPrice = calculateFuelWithRate(array: inputArray, position: i)
            if  currentPrice < cheapest {
                cheapest = currentPrice
            }
        }
        
        return cheapest
    }
}
