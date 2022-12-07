//
//  Day10.swift
//  AdventOfCode
//

import Foundation
import DequeModule

final class Day10: Day {
    
    let scoresTable = [")": 3, "]": 57, "}": 1197, ">": 25137]
    
    func calculateLineScore(_ line: String) -> Int {
        var lineDeq: Deque<Character> = []
        for chr in line {
            switch chr {
            case "(":
                lineDeq.append("(")
            case "[":
                lineDeq.append("[")
            case "{":
                lineDeq.append("{")
            case "<":
                lineDeq.append("<")
            case ")":
                let removedChr = lineDeq.popLast()!
                if removedChr != "(" {
                    return scoresTable[")"]!
                }
            case "]":
                let removedChr = lineDeq.popLast()!
                if removedChr != "[" {
                    return scoresTable["]"]!
                }
            case "}":
                let removedChr = lineDeq.popLast()!
                if removedChr != "{" {
                    return scoresTable["}"]!
                }
            case ">":
                let removedChr = lineDeq.popLast()!
                if removedChr != "<" {
                    return scoresTable[">"]!
                }
            default:
                print("Found an unexpected character")
            }
        }
        return 0
    }
    
    func removePairs(_ line: String) -> Deque<Character> {
        var lineDeq: Deque<Character> = []
        
        for chr in line {
            switch chr {
            case "(":
                lineDeq.append("(")
            case "[":
                lineDeq.append("[")
            case "{":
                lineDeq.append("{")
            case "<":
                lineDeq.append("<")
            case ")":
                let removedChr = lineDeq.popLast()!
                if removedChr != "(" {
                    return []
                }
            case "]":
                let removedChr = lineDeq.popLast()!
                if removedChr != "[" {
                    return []
                }
            case "}":
                let removedChr = lineDeq.popLast()!
                if removedChr != "{" {
                    return []
                }
            case ">":
                let removedChr = lineDeq.popLast()!
                if removedChr != "<" {
                    return []
                }
            default:
                print("Found an unexpected character")
            }
        }

        return lineDeq
    }
    
    func part1(_ input: String) -> CustomStringConvertible {
        return input
            .lines
            .map {line in calculateLineScore(String(line))}
            .sum
        
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let lines = input
            .lines
        
        var scores: Array<Int> = []
        
        for line in lines {
            let deq = removePairs(String(line))
            var score = 0
            if deq != [] {
                for chr in deq.reversed() {
                    switch chr {
                    case "(":
                        score = score * 5 + 1
                    case "[":
                        score = score * 5 + 2
                    case "{":
                        score = score * 5 + 3
                    case "<":
                        score = score * 5 + 4
                    default:
                        score = 0
                    }
                }
                scores.append(score)
            }
        }
        return scores.sorted(by: <)[scores.count / 2]
    }
}
