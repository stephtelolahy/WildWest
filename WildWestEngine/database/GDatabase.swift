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
    
    private let updater: GDatabaseUpdaterProtocol
    
    // MARK: - Init
    
    public init(_ aState: StateProtocol,
                updater: GDatabaseUpdaterProtocol) {
        state = BehaviorSubject(value: aState)
        event = PublishSubject()
        self.updater = updater
    }
    
    // MARK: - DatabaseProtocol
    
    public func update(event aEvent: GEvent) -> Completable {
        Completable.create { [self] completable in
            event.onNext(aEvent)
            if let newState = updater.execute(aEvent, in: currentState) {
                state.onNext(newState)
            }
            completable(.completed)
            return Disposables.create()
        }
    }
}

extension DatabaseProtocol {
    var currentState: StateProtocol {
        guard let result = try? state.value() else {
            fatalError("Failed getting current state")
        }
        return result
    }
}
