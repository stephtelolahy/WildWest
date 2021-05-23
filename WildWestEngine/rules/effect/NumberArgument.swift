//
//  NumberArgument.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 23/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

enum NumberArgument: String, Decodable {
    case zero
    case one = "1"
    case bangsPerTurn
    case bangsCancelable
    case inPlayPlayers
    case excessHand
}

extension PlayReqContext {
    func number(matching arg: NumberArgument) -> Int {
        switch arg {
        case .zero:
            return 0
            
        case .one:
            return 1
            
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

#warning("Fix Duplicate")
extension EffectContext {
    func number(matching arg: NumberArgument) -> Int {
        switch arg {
        case .zero:
            return 0
            
        case .one:
            return 1
            
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


