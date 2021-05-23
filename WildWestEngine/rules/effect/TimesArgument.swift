//
//  TimesArgument.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 23/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

enum TimesArgument: String, Decodable {
    case never
    case once
    case bangsPerTurn
    case bangsCancelable
    case inPlayPlayers
    case excessHand
}

extension PlayReqContext {
    func number(matching arg: TimesArgument) -> Int {
        switch arg {
        case .never:
            return 0
            
        case .once:
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

// TODO: Fix Duplicate
extension EffectContext {
    func number(matching arg: TimesArgument) -> Int {
        switch arg {
        case .never:
            return 0
            
        case .once:
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


