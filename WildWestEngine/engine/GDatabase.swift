//
//  GDatabase.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 24/10/2020.
//

import RxSwift

public class GDatabase: DatabaseProtocol {
    
    // MARK: - Subjects
    
    public let state: BehaviorSubject<StateProtocol>
    public let event: PublishSubject<GEvent>
    
    // MARK: - Dependencies
    
    private let mutableState: GState
    private let updater: GDatabaseUpdaterProtocol
    
    // MARK: - Init
    
    public init(_ aState: StateProtocol,
                updater: GDatabaseUpdaterProtocol) {
        mutableState = GState(aState)
        state = BehaviorSubject(value: aState)
        event = PublishSubject()
        self.updater = updater
    }
    
    // MARK: - DatabaseProtocol
    
    public func update(event aEvent: GEvent) -> Completable {
        Completable.create { [self] completable in
            event.onNext(aEvent)
            updater.execute(aEvent, in: mutableState)
            state.onNext(mutableState)
            completable(.completed)
            return Disposables.create()
        }
    }
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
                      storeView: storeView,
                      hits: hits,
                      played: played)
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
                       abilities: abilities,
                       role: role,
                       maxHealth: maxHealth,
                       health: health,
                       hand: hand,
                       inPlay: inPlay)
    }
}
