//
//  UserDatabase.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 21/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift
import Firebase

protocol UserDatabaseProtocol {
    /*
    func createGame(id: String, state: GameStateProtocol) -> Completable
    func getGame(_ id: String) -> Single<GameStateProtocol>
     */
    func createUser(_ user: UserInfo) -> Completable
    func getUser(_ id: String) -> Single<UserInfo>
    func observeUserStatus(_ id: String) -> Observable<UserStatus>
    /*
    func setUserStatus(_ id: String, status: UserStatus) -> Completable
    func observeWaitingUsers() -> Observable<[UserInfo]>
    func setGameUsers(gameId: String, users: [String: UserInfo]) -> Completable
    func getGameUsers(gameId: String) -> Single<[String: UserInfo]>
 */
}

class UserDatabase: UserDatabaseProtocol {
    
    private let rootRef: DatabaseReference
    private let mapper: FirebaseMapperProtocol
    
    init(rootRef: DatabaseReference,
         mapper: FirebaseMapperProtocol) {
        self.rootRef = rootRef
        self.mapper = mapper
    }
    /*
    func createGame(id: String, state: GameStateProtocol) -> Completable {
        rootRef.child("games/\(id)/state")
            .rxSetValue({ try self.mapper.encodeState(state) })
    }
    
    func getGame(_ id: String) -> Single<GameStateProtocol> {
        rootRef.child("games/\(id)/state")
            .rxObserveSingleEvent { try self.mapper.decodeState(from: $0) }
    }
    */
    func createUser(_ user: UserInfo) -> Completable {
        rootRef.child("users/\(user.id)")
            .rxSetValue({ try self.mapper.encodeUser(user) })
    }
    
    func getUser(_ id: String) -> Single<UserInfo> {
        rootRef.child("users/\(id)")
            .rxObserveSingleEvent({ try self.mapper.decodeUser(from: $0) })
    }
    
    func observeUserStatus(_ id: String) -> Observable<UserStatus> {
        rootRef.child("user_status/\(id)")
            .rxObserve({ try self.mapper.decodeUserStatus(from: $0) })
    }
    /*
    func setUserStatus(_ id: String, status: UserStatus) -> Completable {
        rootRef.child("user_status/\(id)")
            .rxSetValue({ try self.mapper.encodeUserStatus(status) })
    }
    
    func observeWaitingUsers() -> Observable<[UserInfo]> {
        let userStatus = rootRef.child("user_status")
            .rxObserve({ try self.mapper.decodeStatusDictionary(from: $0) })
            
        let users = rootRef.child("users")
            .rxObserve({ try self.mapper.decodeUsers(from: $0) })
            
        return Observable.combineLatest(userStatus, users) { userStatus, users -> [UserInfo] in
            let waitingIds = Array(userStatus.filter { $0.value == .waiting }.keys)
            return users.filter { waitingIds.contains($0.id) }
        }
    }
    
    func setGameUsers(gameId: String, users: [String: UserInfo]) -> Completable {
        rootRef.child("games/\(gameId)/users")
            .rxSetValue({ try self.mapper.encodeGameUsers(users) })
    }
    
    func getGameUsers(gameId: String) -> Single<[String: UserInfo]> {
        rootRef.child("games/\(gameId)/users")
            .rxObserveSingleEvent({ try self.mapper.decodeGameUsers(from: $0) })
    }
 */
}
