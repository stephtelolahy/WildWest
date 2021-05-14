//
//  UserDatabase.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 21/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift
import Firebase
import WildWestEngine

protocol UserDatabaseProtocol {
    
    func createUser(_ user: UserInfo) -> Completable
    func getUser(_ id: String) -> Single<UserInfo>
    func observeUserStatus(_ id: String) -> Observable<UserStatus>
    func setUserStatus(_ id: String, status: UserStatus) -> Completable
    func observeWaitingUsers() -> Observable<[UserInfo]>
    
    func createGameId() -> String
    func createGame(id: String, state: StateProtocol) -> Completable
    func getGame(_ id: String) -> Single<StateProtocol>
    func setGameUsers(id: String, users: [String: UserInfo]) -> Completable
    func getGameUsers(_ gameId: String) -> Single<[String: UserInfo]>
    func createGameDatabase(_ gameId: String, state: StateProtocol) -> RemoteGameDatabase
}

class UserDatabase: UserDatabaseProtocol {
    
    private let rootRef: DatabaseReferenceProtocol
    private let mapper: FirebaseMapperProtocol
    
    init(rootRef: DatabaseReferenceProtocol,
         mapper: FirebaseMapperProtocol) {
        self.rootRef = rootRef
        self.mapper = mapper
    }
    
    func createUser(_ user: UserInfo) -> Completable {
        rootRef.rxSetValue("users/\(user.id)") { try self.mapper.encodeUser(user) }
    }
    
    func getUser(_ id: String) -> Single<UserInfo> {
        rootRef.rxObserveSingleEvent("users/\(id)") { try self.mapper.decodeUser(from: $0) }
    }
    
    func observeUserStatus(_ id: String) -> Observable<UserStatus> {
        rootRef.rxObserve("user_status/\(id)") { try self.mapper.decodeUserStatus(from: $0) }
    }
    
    func setUserStatus(_ id: String, status: UserStatus) -> Completable {
        rootRef.rxSetValue("user_status/\(id)") { try self.mapper.encodeUserStatus(status) }
    }
    
    func observeWaitingUsers() -> Observable<[UserInfo]> {
        let userStatus = rootRef.rxObserve("user_status") { try self.mapper.decodeUserStatuses(from: $0) }
        let users = rootRef.rxObserve("users") { try self.mapper.decodeUsers(from: $0) }
        return Observable.combineLatest(userStatus, users) { userStatus, users -> [UserInfo] in
            let waitingIds = Array(userStatus.filter { $0.value == .waiting }.keys)
            return users.filter { waitingIds.contains($0.id) }
        }
    }
    
    func createGameId() -> String {
        rootRef.childByAutoIdKey()
    }
    
    func createGame(id: String, state: StateProtocol) -> Completable {
        rootRef.rxSetValue("games/\(id)/state") { try self.mapper.encodeState(state) }
    }
    
    func getGame(_ id: String) -> Single<StateProtocol> {
        rootRef.rxObserveSingleEvent("games/\(id)/state") { try self.mapper.decodeState(from: $0) }
    }
    
    func setGameUsers(id: String, users: [String: UserInfo]) -> Completable {
        rootRef.rxSetValue("games/\(id)/users") { try self.mapper.encodeGameUsers(users) }
    }
    
    func getGameUsers(_ gameId: String) -> Single<[String: UserInfo]> {
        rootRef.rxObserveSingleEvent("games/\(gameId)/users") { try self.mapper.decodeGameUsers(from: $0) }
    }
    
    func createGameDatabase(_ gameId: String, state: StateProtocol) -> RemoteGameDatabase {
        let gameRef = rootRef.childRef("games/\(gameId)")
        let updater = RemoteGameDatabaseUpdater(gameRef: gameRef)
        return RemoteGameDatabase(state,
                                  gameRef: gameRef,
                                  mapper: mapper,
                                  updater: updater)
    }
}
