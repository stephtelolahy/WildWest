//
//  DataBase+Restricted.swift
//  WildWestEngine
//
//  Created by TELOLAHY Hugues Stéphano on 15/07/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//
import RxSwift

public extension RestrictedDatabaseProtocol where Self: DatabaseProtocol {
    
    func state(observedBy actor: String?) -> Observable<StateProtocol> {
        state.map { $0.observed(by: actor) }
    }
}

private extension StateProtocol {
    func observed(by actor: String?) -> StateProtocol {
        let players: [String: PlayerProtocol] = self.players.mapValues { $0.observed(by: actor, in: self) }
        let initialOrder = self.initialOrder.starting(with: actor)
        return GState(players: players,
                      initialOrder: initialOrder,
                      playOrder: playOrder,
                      turn: turn,
                      phase: phase,
                      deck: deck,
                      discard: discard,
                      store: store,
                      hits: hits,
                      played: played,
                      history: history,
                      winner: winner)
    }
}

private extension PlayerProtocol {
    func observed(by actor: String?, in state: StateProtocol) -> PlayerProtocol {
        let hideRole = state.winner == nil
            && state.playOrder.contains(identifier)
            && identifier != actor
            && role != .sheriff
        let role: Role? = hideRole ? nil : self.role
        return GPlayer(identifier: identifier,
                       name: name,
                       desc: desc,
                       attributes: attributes,
                       abilities: abilities,
                       role: role,
                       health: health,
                       hand: hand,
                       inPlay: inPlay)
    }
}
