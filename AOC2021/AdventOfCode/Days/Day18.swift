//
//  Day18.swift
//  AdventOfCode
//

import Foundation

final class Day18: Day {
    
    indirect enum SnailfishNumber {
        case number(Int)
        case snailfishNumber((SnailfishNumber, SnailfishNumber))
        
        func unwrapNumber() -> Int {
            switch self {
            case .number(let int):
                return int
            default:
                abort()
            }
        }
    }
    
    func snailfishNumberParse(of line: inout String) -> SnailfishNumber {
        let char = line.first!
        if char != "[" && char != "]" && char != "," {
            line.removeFirst()
            return SnailfishNumber.number(Int(String(char))!)
        } else {
            line.removeFirst()
            let first = snailfishNumberParse(of: &line)
            line.removeFirst()
            let second = snailfishNumberParse(of: &line)
            line.removeFirst()
            return SnailfishNumber.snailfishNumber((first, second))
        }
    }
    
    func add(first: SnailfishNumber, second: SnailfishNumber) -> SnailfishNumber {
        var sum = SnailfishNumber.snailfishNumber((first, second))
        while true {
            let exploded = explode(number: sum)
            if !exploded.0 {
                let split = split(number: exploded.2)
                if !split.0 {
                    return split.1
                } else {
                    sum = split.1
                }
            } else {
                sum = exploded.2
            }
        }
        return sum
    }
    
    func split(number: SnailfishNumber) -> (Bool, SnailfishNumber) {
        switch number {
        case .number(let int):
            if int >= 10 {
                
                return (true, SnailfishNumber.snailfishNumber((SnailfishNumber.number(Int((Double(int)/2.0).rounded(.down))), SnailfishNumber.number(Int((Double(int)/2.0).rounded(.up))))))
            } else {
                return (false, SnailfishNumber.number(int))
            }
        case .snailfishNumber((var part1, var part2)):
            let part1Split = split(number: part1)
            var part2Split = false
            part1 = part1Split.1
            if !part1Split.0 {
                part2Split = split(number: part2).0
                part2 = split(number: part2).1
            }
            return (part1Split.0 || part2Split, SnailfishNumber.snailfishNumber((part1, part2)))
        }
    }
    
    func explode(number: SnailfishNumber, n: Int = 4) -> (Bool, Int?, SnailfishNumber, Int?) {
        switch number {
        case .number:
            return (false, nil, number, nil)
        case .snailfishNumber((let a, let b)):
            if n == 0 {
                return (true, a.unwrapNumber(), SnailfishNumber.number(0), b.unwrapNumber())
            } else {
                let (e, l, num, r) = explode(number: a, n: n - 1)
                if !e {
                    let (e2, l2, num2, r2) = explode(number: b, n: n - 1)
                    if !e2 {
                        return (false, nil, SnailfishNumber.snailfishNumber((num, num2)), nil)
                    } else {
                        return (true, nil, SnailfishNumber.snailfishNumber((addRight(data: num, x: l2), num2)), r2)
                    }
                } else {
                    return (true, l, SnailfishNumber.snailfishNumber((num, addLeft(data: b, x: r))), nil)
                }
            }
        }
    }
    
    func addRight(data: SnailfishNumber, x: Int?) -> SnailfishNumber {
        guard x != nil else {
            return data
        }
        switch data {
        case .number(let int):
            return SnailfishNumber.number(int + x!)
        case .snailfishNumber((let a, let b)):
            return SnailfishNumber.snailfishNumber((a, addRight(data: b, x: x)))
        }
    }
    
    func addLeft(data: SnailfishNumber, x: Int?) -> SnailfishNumber {
        guard x != nil else {
            return data
        }
        switch data {
        case .number(let int):
            return SnailfishNumber.number(int + x!)
        case .snailfishNumber((let a, let b)):
            return SnailfishNumber.snailfishNumber((addLeft(data: a, x: x), b))
        }
    }
    
    func calculateMagnitude(data: SnailfishNumber) -> Int {
        switch data {
        case .number(let int):
            return int
        case .snailfishNumber((let a, let b)):
            return 3 * calculateMagnitude(data: a) + 2 * calculateMagnitude(data: b)
        }
    }
    
    func part1(_ input: String) -> CustomStringConvertible {
        let parsedInput = input.lines
        var snailfishInput = [SnailfishNumber]()
        for line in parsedInput {
            var lineToPass = String(line)
            snailfishInput.append(snailfishNumberParse(of: &lineToPass))
        }
        
        let res = snailfishInput[1...].reduce(snailfishInput[0], add)
        
        print(res)
        return calculateMagnitude(data: res)
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let parsedInput = input.lines
        var snailfishInput = [SnailfishNumber]()
        for line in parsedInput {
            var lineToPass = String(line)
            snailfishInput.append(snailfishNumberParse(of: &lineToPass))
        }
        
        var maximumMagnitude = Int.min
        for i in snailfishInput.indices {
            for j in snailfishInput.indices {
                let res = add(first: snailfishInput[i], second: snailfishInput[j])
                let magnitude = calculateMagnitude(data: res)
                if  magnitude > maximumMagnitude {
                    maximumMagnitude = magnitude
                }
            }
        }
        
        return maximumMagnitude
    }
}
