//
//  MatchingDatabase.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 21/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift
import Firebase

protocol MatchingDatabaseProtocol {
    func createGame(id: String, state: GameStateProtocol) -> Completable
    func getGame(_ id: String) -> Single<GameStateProtocol>
    func createUser(_ user: WUserInfo) -> Completable
    func observeUserStatus(_ id: String) -> Observable<UserStatus>
    func setUserStatus(_ id: String, status: UserStatus) -> Completable
    func observeAllUsers() -> Observable<[WUserInfo]>
}

class MatchingDatabase: MatchingDatabaseProtocol {
    
    private let rootRef: DatabaseReference
    private let mapper: FirebaseMapperProtocol
    
    init(rootRef: DatabaseReference,
         mapper: FirebaseMapperProtocol) {
        self.rootRef = rootRef
        self.mapper = mapper
    }
    
    func createGame(id: String, state: GameStateProtocol) -> Completable {
        rootRef.child("games/\(id)/state").rxSetValue({ try self.mapper.encodeState(state) })
            .andThen(rootRef.child("games/\(id)/executedMove").rxSetValue({ nil }))
            .andThen(rootRef.child("games/\(id)/executedUpdate").rxSetValue({ nil }))
            .andThen(rootRef.child("games/\(id)/validMoves").rxSetValue({ nil }))
    }
    
    func getGame(_ id: String) -> Single<GameStateProtocol> {
        rootRef.child("games/\(id)/state")
            .rxObserveSingleEvent { try self.mapper.decodeState(from: $0) }
    }
    
    func createUser(_ user: WUserInfo) -> Completable {
        rootRef.child("users/\(user.id)")
            .rxSetValue({ try self.mapper.encodeUser(user) })
    }
    
    func observeUserStatus(_ id: String) -> Observable<UserStatus> {
        rootRef.child("users/\(id)/status")
            .rxObserve({ try self.mapper.decodeUserStatus(from: $0) })
    }
    
    func setUserStatus(_ id: String, status: UserStatus) -> Completable {
        rootRef.child("users/\(id)/status")
            .rxSetValue({ try self.mapper.encodeUserStatus(status) })
    }
    
    func observeAllUsers() -> Observable<[WUserInfo]> {
        rootRef.child("users")
            .rxObserve({ try self.mapper.decodeUsers(from: $0) })
    }
}
