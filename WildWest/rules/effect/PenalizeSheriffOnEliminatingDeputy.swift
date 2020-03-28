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
            let actor = state.eliminated.first(where: { $0.identifier == move.actorId }),
            actor.role == .deputy,
            let damageEvent = state.damageEvents.last,
            damageEvent.playerId == actor.identifier,
            case let .byPlayer(offenderId) = damageEvent.source,
            let offender = state.players.first(where: { $0.identifier == offenderId }),
            case .sheriff = offender.role else {
                return nil
        }
        
        return GameMove(name: .penalizeSheriffOnEliminatingDeputy, actorId: offenderId)
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .penalizeSheriffOnEliminatingDeputy = move.name,
            let actorId = move.actorId,
            let actor = state.players.first(where: { $0.identifier == actorId }) else {
                return nil
        }
        
        var updates: [GameUpdate] = []
        actor.hand.forEach { updates.append(.playerDiscardHand(actorId, $0.identifier)) }
        actor.inPlay.forEach { updates.append(.playerDiscardInPlay(actorId, $0.identifier)) }
        return updates
    }
}

extension MoveName {
    static let penalizeSheriffOnEliminatingDeputy = MoveName("penalizeSheriffOnEliminatingDeputy")
}
