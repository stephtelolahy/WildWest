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
        mutableState = GState.copy(aState)
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
