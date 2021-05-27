//
//  NumberArgument.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 23/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

enum NumberArgument: Decodable {
    case number(Int)
    case bangsPerTurn
    case bangsCancelable
    case inPlayPlayers
    case excessHand
    case damage
    
    init(from decoder: Decoder) throws {
        let string = try decoder.singleValueContainer().decode(String.self)
        self = try Self.create(from: string)
    }
    
    init(from data: Any) throws {
        guard let string = data as? String else {
            throw DecodingError.typeMismatch(String.self, DecodingError.Context(codingPath: [], debugDescription: ""))
        }
        self = try Self.create(from: string)
    }
    
    static func create(from string: String) throws -> NumberArgument {
        switch string {
        case "bangsPerTurn":
            return .bangsPerTurn
            
        case "bangsCancelable":
            return .bangsCancelable
            
        case "inPlayPlayers":
            return .inPlayPlayers
            
        case "excessHand":
            return .excessHand
            
        case "damage":
            return .damage
            
        default:
            guard let intValue = Int(string) else {
                throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: [], debugDescription: "Invalid int"))
            }
            
            return .number(intValue)
        }
    }
}

extension MoveContext {
    func number(matching arg: NumberArgument) -> Int {
        switch arg {
        case let .number(value):
            return value
            
        case .bangsPerTurn:
            return actor.bangsPerTurn
            
        case .bangsCancelable:
            return actor.bangsCancelable
            
        case .inPlayPlayers:
            return state.playOrder.count
            
        case .excessHand:
            return Swift.max(actor.hand.count - actor.handLimit, 0)
            
        case .damage:
            return actor.maxHealth - actor.health
        }
    }
}
