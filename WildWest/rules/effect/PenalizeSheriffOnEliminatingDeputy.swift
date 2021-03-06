//
//  PenalizeSheriffOnEliminatingDeputy.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 22/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable type_name

class PenalizeSheriffOnEliminatingDeputyMatcher: MoveMatcherProtocol {
    
    func effect(onExecuting move: GameMove, in state: GameStateProtocol) -> GameMove? {
        guard case .eliminate = move.name,
            let actor = state.allPlayers.first(where: { $0.identifier == move.actorId }),
            actor.role == .deputy,
            let damageEvent = actor.lastDamage,
            case let .byPlayer(offenderId) = damageEvent.source,
            let offender = state.player(offenderId),
            case .sheriff = offender.role else {
                return nil
        }
        
        return GameMove(name: .penalizeSheriffOnEliminatingDeputy, actorId: offenderId)
    }
    
    func updates(onExecuting move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .penalizeSheriffOnEliminatingDeputy = move.name,
            let actor = state.player(move.actorId) else {
                return nil
        }
        
        var updates: [GameUpdate] = []
        actor.hand.forEach { updates.append(.playerDiscardHand(move.actorId, $0.identifier)) }
        actor.inPlay.forEach { updates.append(.playerDiscardInPlay(move.actorId, $0.identifier)) }
        return updates
    }
}

extension MoveName {
    static let penalizeSheriffOnEliminatingDeputy = MoveName("penalizeSheriffOnEliminatingDeputy")
}
