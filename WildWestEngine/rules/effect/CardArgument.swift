//
//  CardArgument.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

enum CardArgument: String, Decodable {
    case requiredHand
    case randomHand
    case requiredInPlay
    case requiredStore
    case requiredDeck
    case played
    case allHand
    case allInPlay
}

extension EffectContext {
    
    func cards(matching arg: CardArgument, player: String) -> [String]  {
        switch arg {
        case .requiredHand:
            return args[.requiredHand]!
            
        case .randomHand:
            let hand = state.players[player]!.hand
            guard !hand.isEmpty else {
                return []
            }
            return [hand.randomElement()!.identifier]
            
        case .requiredInPlay:
            return args[.requiredInPlay]!
            
        case .requiredStore:
            return args[.requiredStore]!
            
        case .requiredDeck:
            return args[.requiredDeck]!
            
        case .played:
            switch card {
            case let .hand(handCard):
                return [handCard]
                
            case let .inPlay(inPlayCard):
                return [inPlayCard]
                
            default:
                fatalError("Missing played card")
            }
            
        case .allHand:
            return state.players[player]!.hand.map { $0.identifier }
            
        case .allInPlay:
            return state.players[player]!.inPlay.map { $0.identifier }
        }
    }
}
