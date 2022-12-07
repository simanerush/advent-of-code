//
//  Day16.swift
//  AdventOfCode
//

import Foundation

struct Transmission {
    var contents: String
    
    func decodeContents() -> String {
        var decoded = ""
        for char in self.contents {
            let newString = String(Int(String(char), radix: 16)!, radix: 2)
            let zeroes = String(repeating: "0", count: 4 - newString.count)
            decoded.append(contentsOf: zeroes + newString)
        }
        return decoded
    }
}

struct Packet {
    let version: String
    let id: String
    let packetType: PacketType
    
    enum PacketType {
        case literal(Int)
        case op([Packet])
    }
    
    func getVersion() -> String {
        return version
    }
    
    func versionSum() -> Int {
        switch packetType {
        case .literal:
            return Int(version, radix: 2)!
        case .op(let array):
            var sum = Int(version, radix: 2)!
            for element in array {
                sum += element.versionSum()
            }
            return sum
        }
    }
    
    func value() -> Int {
        switch id {
        case "000":
            var sum = 0
            switch packetType {
            case .literal:
                break
            case .op(let array):
                for element in array {
                    sum += element.value()
                }
            }
            return sum
        case "001":
            var product = 1
            switch packetType {
            case .literal:
                break
            case .op(let array):
                for element in array {
                    product *= element.value()
                }
            }
            return product
        case "010":
            switch packetType {
            case .literal:
                break
            case .op(let array):
                return array.map{ x in x.value()}.min()!
            }
        case "011":
            switch packetType {
            case .literal:
                break
            case .op(let array):
                return array.map{ x in x.value()}.max()!
            }
        case "100":
            switch packetType {
            case .literal(let int):
                return int
            case .op:
                break
            }
        case "101":
            switch packetType {
            case .literal:
                break
            case .op(let array):
                if array[0].value() > array[1].value() {
                    return 1
                } else {
                    return 0
                }
            }
        case "110":
            switch packetType {
            case .literal:
                break
            case .op(let array):
                if array[0].value() < array[1].value() {
                    return 1
                } else {
                    return 0
                }
            }
        case "111":
            switch packetType {
            case .literal:
                break
            case .op(let array):
                print(array[0].value())
                print(array[1].value())
                if array[0].value() == array[1].value() {
                    return 1
                } else {
                    return 0
                }
            }
        default:
            return -1
        }
        print("I fucked up")
        return -1
    }
}

func createPacket(from string: inout String) -> Packet {
    let transmissionVersion =  string.prefix(3)
    string = String(string.suffix(string.count - 3))
    let packetTypeId = string.prefix(3)
    string = String(string.suffix(string.count - 3))
    if packetTypeId == "100" {
        var bits = ""
        while true {
            let group = String(string.prefix(5))
            string = String(string.suffix(string.count - 5))
            if group.prefix(1) == "1" {
                bits.append(contentsOf: group.suffix(4))
            } else if group.prefix(1) == "0" {
                bits.append(contentsOf: group.suffix(4))
                break
            }
        }
        let result = Int(bits, radix: 2)!
        
        return Packet(version: String(transmissionVersion), id: String(packetTypeId), packetType: .literal(result))
    } else {
        let lengthTypeId = string.prefix(1)
        string = String(string.suffix(string.count - 1))
        var packetsArray = [Packet]()
        if lengthTypeId == "1" {
            let numberOfPackets = string.prefix(11)
            string = String(string.suffix(string.count - 11))
            let numberOfPacketsDecimal = Int(numberOfPackets, radix: 2)!
            for _ in 0..<numberOfPacketsDecimal {
                packetsArray.append(createPacket(from: &string))
            }
            return Packet(version: String(transmissionVersion), id: String(packetTypeId), packetType: .op(packetsArray))
        } else {
            let lengthOfAllPackets = string.prefix(15)
            string = String(string.suffix(string.count - 15))
            let lengthOfAllPacketsDecimal = Int(lengthOfAllPackets, radix: 2)!
            let endString = string.count - lengthOfAllPacketsDecimal
            while string.count > endString {
                packetsArray.append(createPacket(from: &string))
            }
            return Packet(version: String(transmissionVersion), id: String(packetTypeId), packetType: .op(packetsArray))
        }
    }
}

final class Day16: Day {
    func part1(_ input: String) -> CustomStringConvertible {
        let input = input.lines
        let transmissionPacket = Transmission(contents: String(input[0]))
        var transmissionPacketDecoded = transmissionPacket.decodeContents()
        // var contents = "00111000000000000110111101000101001010010001001000000000"
        let allPackets = createPacket(from: &transmissionPacketDecoded)
        
        return allPackets.versionSum()
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let input = input.lines
        let transmissionPacket = Transmission(contents: String(input[0]))
        var transmissionPacketDecoded = transmissionPacket.decodeContents()
        let allPackets = createPacket(from: &transmissionPacketDecoded)
        
        return allPackets.value()
    }
}
