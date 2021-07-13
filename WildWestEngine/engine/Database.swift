//
//  Database.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 20/10/2020.
//

import RxSwift

/// Exposing state shown to a specific player
public protocol RestrictedDatabaseProtocol {
    var event: PublishSubject<GEvent> { get }
    
    func state(observedBy actor: String?) -> Observable<StateProtocol>
}

/// Exposing and modifying general state
public protocol DatabaseProtocol: RestrictedDatabaseProtocol {
    var state: BehaviorSubject<StateProtocol> { get }
    
    func update(event: GEvent) -> Completable
}

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
