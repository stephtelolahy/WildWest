//
//  ParsedTimesValue.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 23/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

enum TimesValue: String, Decodable {
    case never
    case bangsPerTurn
    case bangsCancelable
    case inPlayPlayers
    case excessHand
}

@propertyWrapper class ParsedTimesValue: ParsableValue {
    
    var wrappedValue: TimesValue = .never
    
    func parse(_ data: Any) throws {
        guard let rawValue = data as? String,
              let value = TimesValue(rawValue: rawValue) else {
            throw DecodingError.typeMismatch(String.self, DecodingError.Context(codingPath: [], debugDescription: ""))
        }
        
        wrappedValue = value
    }
}

extension PlayReqContext {
    func number(matching arg: TimesValue) -> Int {
        switch arg {
        case .never:
            return 0
            
        case .bangsPerTurn:
            return actor.bangsPerTurn
            
        case .bangsCancelable:
            return actor.bangsCancelable
            
        case .inPlayPlayers:
            return state.playOrder.count
            
        case .excessHand:
            return Swift.max(actor.hand.count - actor.handLimit, 0)
        }
    }
}

extension EffectContext {
    func number(matching arg: TimesValue) -> Int {
        switch arg {
        case .never:
            return 0
            
        case .bangsPerTurn:
            return actor.bangsPerTurn
            
        case .bangsCancelable:
            return actor.bangsCancelable
            
        case .inPlayPlayers:
            return state.playOrder.count
            
        case .excessHand:
            return Swift.max(actor.hand.count - actor.handLimit, 0)
        }
    }
}

