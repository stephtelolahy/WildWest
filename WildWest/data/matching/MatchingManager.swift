//
//  MatchingManager.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

protocol MatchingManagerProtocol {
    func createUser() -> Completable
    func observeUserStatus() -> Observable<UserStatus>
    func addToWaitingRoom() -> Completable
    func quitWaitingRoom() -> Completable
    func observeWaitingUsers() -> Observable<[WUserInfo]>
    func createGame(users: [WUserInfo]) -> Completable
    func quitGame() -> Completable
    func getGameData(gameId: String) -> Single<(GameStateProtocol, [String: WUserInfo])>
}

class MatchingManager: MatchingManagerProtocol {
    
    private let accountManager: AccountManagerProtocol
    private let database: MatchingDatabaseProtocol
    private let gameBuilder: GameBuilderProtocol
    
    init(accountManager: AccountManagerProtocol,
         database: MatchingDatabaseProtocol,
         gameBuilder: GameBuilderProtocol) {
        self.accountManager = accountManager
        self.database = database
        self.gameBuilder = gameBuilder
    }
    
    func createUser() -> Completable {
        guard let user = accountManager.currentUser else {
            fatalError("Missing user")
        }
        return database.createUser(user)
    }
    
    func observeUserStatus() -> Observable<UserStatus> {
        database.observeUserStatus(loggedUserId)
    }
    
    func addToWaitingRoom() -> Completable {
        database.setUserStatus(loggedUserId, status: .waiting)
    }
    
    func quitWaitingRoom() -> Completable {
        database.setUserStatus(loggedUserId, status: .idle)
    }
    
    func quitGame() -> Completable {
        database.setUserStatus(loggedUserId, status: .idle)
    }
    
    func observeWaitingUsers() -> Observable<[WUserInfo]> {
        database.observeWaitingUsers()
    }
    
    func createGame(users: [WUserInfo]) -> Completable {
        let state = gameBuilder.createGame(for: users.count)
        let gameId = FirebaseKeyGenerator().autoId()
        
        let playerIds = state.allPlayers.map { $0.identifier }
        let updates: [Completable] = users.enumerated().map { index, user in
            database.setUserStatus(user.id, status: .playing(gameId: gameId, playerId: playerIds[index]))
        }
        
        var usersDict: [String: WUserInfo] = [:]
        for (index, user) in users.enumerated() {
            usersDict[playerIds[index]] = user
        }
        
        return database.createGame(id: gameId, state: state)
            .andThen(database.setGameUsers(gameId: gameId, users: usersDict))
            .andThen(Completable.concat(updates))
    }
    
    func getGameData(gameId: String) -> Single<(GameStateProtocol, [String: WUserInfo])> {
        database.getGame(gameId)
        .flatMap {  state in
            self.database.getGameUsers(gameId: gameId)
                .map { users in (state, users) }
        }
    }
    
    private var loggedUserId: String {
        guard let user = accountManager.currentUser else {
            fatalError("Missing user")
        }
        
        return user.id
    }
}
