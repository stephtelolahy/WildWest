//
//  DrawsAnotherCardIfSecondDrawIsRedSuit.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 17/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable type_name

class DrawsAnotherCardIfSecondDrawIsRedSuitMatcher: MoveMatcherProtocol {
    
    func effect(onExecuting move: GameMove, in state: GameStateProtocol) -> GameMove? {
        guard case .startTurn = move.name,
            let actor = state.player(move.actorId),
            actor.abilities[.drawsAnotherCardIfSecondDrawIsRedSuit] == true else {
                return nil
        }
        
        return GameMove(name: .drawsAnotherCardIfSecondDrawIsRedSuit, actorId: actor.identifier)
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .drawsAnotherCardIfSecondDrawIsRedSuit = move.name else {
            return nil
        }
        
        return [.playerPullFromDeck(move.actorId)]
    }
}

extension MoveName {
    static let drawsAnotherCardIfSecondDrawIsRedSuit = MoveName("drawsAnotherCardIfSecondDrawIsRedSuit")
}
