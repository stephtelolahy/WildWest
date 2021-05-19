//
//  RemoteGameDatabase.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift
import Firebase
import WildWestEngine

public class RemoteGameDatabase: DatabaseProtocol {
    
    // MARK: - Dependencies
    
    private let gameRef: DatabaseReferenceProtocol
    private let mapper: FirebaseMapperProtocol
    private let updater: RemoteGameDatabaseUpdaterProtocol
    
    // MARK: - Subjects
    
    public let state: BehaviorSubject<StateProtocol>
    public let event: PublishSubject<GEvent>
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    init(_ aState: StateProtocol,
         gameRef: DatabaseReferenceProtocol,
         mapper: FirebaseMapperProtocol,
         updater: RemoteGameDatabaseUpdaterProtocol) {
        self.gameRef = gameRef
        self.mapper = mapper
        self.updater = updater
        state = BehaviorSubject(value: aState)
        event = PublishSubject()
        
        observeStateChanges()
        observeEventChanges()
    }
    
    // MARK: - DatabaseProtocol
    
    public func update(event aEvent: GEvent) -> Completable {
        gameRef.rxSetValue("events", encoding: { try self.mapper.encodeEvent(aEvent) })
            .andThen(updater.execute(aEvent))
    }
}

private extension RemoteGameDatabase {
    
    func observeStateChanges() {
        gameRef.rxObserve("state", decoding: { try self.mapper.decodeState(from: $0) })
            .subscribe(onNext: { [weak self] aState in
                self?.state.onNext(aState)
            })
            .disposed(by: disposeBag)
    }
    
    func observeEventChanges() {
        gameRef.rxObserve("events", decoding: { try self.mapper.decodeEvent(from: $0) })
            .subscribe(onNext: { [weak self] anEvent in
                self?.event.onNext(anEvent)
            })
            .disposed(by: disposeBag)
    }
}
