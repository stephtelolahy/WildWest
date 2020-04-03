//
//  DrawsCardFromPlayerDamagedHim.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 02/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class DrawsCardFromPlayerDamagedHimMatcher: MoveMatcherProtocol {
    
    func effect(onExecuting move: GameMove, in state: GameStateProtocol) -> GameMove? {
        guard case .pass = move.name,
            let actor = state.player(move.actorId),
            actor.health > 0,
            actor.abilities[.drawsCardFromPlayerDamagedHim] == true,
            let damageEvent = state.damageEvents.last,
            damageEvent.playerId == move.actorId,
            case let .byPlayer(offenderId) = damageEvent.source,
            offenderId != move.actorId,
            let offender = state.player(offenderId),
            let card = offender.hand.randomElement() else {
                return nil
        }
        
        return GameMove(name: .drawsCardFromPlayerDamagedHim,
                        actorId: move.actorId,
                        cardId: card.identifier,
                        targetId: offender.identifier)
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .drawsCardFromPlayerDamagedHim = move.name,
            let targetId = move.targetId,
            let cardId = move.cardId else {
                return nil
        }
        
        return [.playerPullFromOtherHand(move.actorId, targetId, cardId)]
    }
}

extension MoveName {
    static let drawsCardFromPlayerDamagedHim = MoveName("drawsCardFromPlayerDamagedHim")
}
