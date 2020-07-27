//
//  MatchingManager.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Firebase
import FirebaseUI
import RxSwift

protocol MatchingManagerProtocol {
    func createUser() -> Completable
    func observeUserStatus() -> Observable<UserStatus>
    func addToWaitingRoom() -> Completable
    func quitWaitingRoom() -> Completable
    func quitGame() -> Completable
    func observeWaitingUsers() -> Observable<[WUserInfo]>
}

class MatchingManager: MatchingManagerProtocol {
    
    private let database: MatchingDatabaseProtocol
    
    init(database: MatchingDatabaseProtocol) {
        self.database = database
    }
    
    func createUser() -> Completable {
        guard let user = Auth.auth().currentUser else {
            fatalError("Missing user")
        }
        
        let userInfo = WUserInfo(id: user.uid,
                                 name: user.displayName ?? "",
                                 photoUrl: user.photoURL?.absoluteString ?? "",
                                 status: .idle)
        return database.createUser(userInfo)
    }
    
    func observeUserStatus() -> Observable<UserStatus> {
        database.observeUserStatus(currentUserId)
    }
    
    func addToWaitingRoom() -> Completable {
        database.setUserStatus(currentUserId, status: .waiting)
    }
    
    func quitWaitingRoom() -> Completable {
        database.setUserStatus(currentUserId, status: .idle)
    }
    
    func quitGame() -> Completable {
        database.setUserStatus(currentUserId, status: .idle)
    }
    
    func observeWaitingUsers() -> Observable<[WUserInfo]> {
        database.observeAllUsers()
            .map { $0.filter { $0.status == .waiting } }
    }
}

private extension MatchingManager {
    
    var currentUserId: String {
        guard let user = Auth.auth().currentUser else {
            fatalError("Missing user")
        }
        
        return user.uid
    }
    /*
    // 1: get waiting users
    // 2: create game
    // 3: update playing users
    func match() -> Completable {
        getWaitingUsers(atLeast: 2)
            .flatMapCompletable { users in
                let state = GameBuilder().createGame(for: users.count)
                let gameId = FirebaseKeyGenerator().autoId()
                return self.database.createGame(id: gameId, state: state)
                    .andThen(self.updatePlayingUsers(users: users, gameId: gameId, state: state))
            }
    }
    
    func getWaitingUsers(atLeast min: Int) -> Single<[WUserInfo]> {
        database.getAllUsers()
            .map { users in
                let waitingUsers = users.filter { $0.status == .waiting }
                guard waitingUsers.count >= min else {
                    throw NSError(domain: "Not enouth waiting users", code: 0)
                }
                
                return waitingUsers
            }
    }
    
    func updatePlayingUsers(users: [WUserInfo], gameId: String, state: GameStateProtocol) -> Completable {
        let playerIds = state.allPlayers.map { $0.identifier }
        let updates: [Completable] = users.enumerated().map { index, user in
            database.setUserStatus(user.id, status: .playing(gameId: gameId, playerId: playerIds[index]))
        }
        return Completable.concat(updates)
    }
 */
    
}
