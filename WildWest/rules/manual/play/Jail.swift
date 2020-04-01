//
//  Jail.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class JailMatcher: MoveMatcherProtocol {
    
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard state.challenge == nil,
            let actor = state.player(state.turn),
            let cards = actor.handCards(named: .jail) else {
                return nil
        }
        
        let otherPlayers = state.players.filter { player in
            guard player.identifier != actor.identifier,
                player.role != .sheriff,
                player.inPlayCards(named: .jail) == nil else {
                    return false
            }
            
            return true
        }
        
        guard !otherPlayers.isEmpty else {
            return nil
        }
        
        return cards.map { card in
            otherPlayers.map {
                GameMove(name: .play, actorId: actor.identifier, cardId: card.identifier, targetId: $0.identifier)
            }
        }.flatMap { $0 }
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .play = move.name,
            let cardId = move.cardId,
            let actor = state.player(move.actorId),
            let card = actor.handCard(cardId),
            case .jail = card.name,
            let targetId = move.targetId else {
                return nil
        }
        
        return [.playerPutInPlayOfOther(move.actorId, targetId, cardId)]
    }
}
