//
//  NumberArgument.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 23/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

enum NumberAttribute: String {
    case bangsPerTurn
    case bangsCancelable
    case inPlayPlayers
    case excessHand
    case damage
    case weapon
}

enum NumberArgument: Decodable {
    case number(Int)
    case attribute(NumberAttribute)
    
    init(from decoder: Decoder) throws {
        if let intValue = try? decoder.singleValueContainer().decode(Int.self) {
            self = .number(intValue)
            return
        }
        
        let string = try decoder.singleValueContainer().decode(String.self)
        self = try Self.parse(from: string)
    }
    
    init(from data: Any) throws {
        if let intValue = data as? Int {
            self = .number(intValue)
            return
        }
        
        guard let string = data as? String else {
            throw DecodingError.typeMismatch(String.self, DecodingError.Context(codingPath: [], debugDescription: ""))
        }
        self = try Self.parse(from: string)
    }
    
    private static func parse(from string: String) throws -> NumberArgument {
        guard let attribute = NumberAttribute(rawValue: string) else {
            throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: [], debugDescription: "Invalid value"))
        }
        
        return .attribute(attribute)
    }
}

extension PlayContext {
    func get(_ arg: NumberArgument) -> Int {
        switch arg {
        case let .number(value):
            return value
            
        case let .attribute(attribute):
            switch attribute {
            case .bangsPerTurn:
                return AttributeRules.bangsPerTurn(for: actor)
                
            case .bangsCancelable:
                return AttributeRules.bangsCancelable(for: actor)
                
            case .inPlayPlayers:
                return state.playOrder.count
                
            case .excessHand:
                return Swift.max(actor.hand.count - AttributeRules.handLimit(for: actor), 0)
                
            case .damage:
                return AttributeRules.maxHealth(for: actor) - actor.health
                
            case .weapon:
                return AttributeRules.weapon(for: actor)
            }
        }
    }
}
