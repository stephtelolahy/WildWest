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
