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
    case three = "3"
    case bangsPerTurn
    case bangsCancelable
    case inPlayPlayers
    case excessHand
}

extension PlayReqContext {
    func number(matching arg: NumberArgument) -> Int {
        arg.intValue(actor: actor, state: state)
    }
}

extension EffectContext {
    func number(matching arg: NumberArgument) -> Int {
        arg.intValue(actor: actor, state: state)
    }
}

private extension NumberArgument {
    func intValue(actor: PlayerProtocol, state: StateProtocol) -> Int {
        switch self {
        case .zero:
            return 0
            
        case .one:
            return 1
            
        case .three:
            return 3
            
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
