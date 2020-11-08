//
//  MatchingManager.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
/*
import RxSwift
import FirebaseUI

protocol MatchingManagerProtocol {
    var isLoggedIn: Bool { get }
    
    func createUser(_ user: WUserInfo) -> Completable
    func getUser() -> Single<WUserInfo>
    func observeUserStatus() -> Observable<UserStatus>
    func addToWaitingRoom() -> Completable
    func quitWaitingRoom() -> Completable
    func observeWaitingUsers() -> Observable<[WUserInfo]>
    func createGame(users: [WUserInfo]) -> Completable
    func quitGame() -> Completable
    func getGameData(gameId: String) -> Single<(GameStateProtocol, [String: WUserInfo])>
}

class MatchingManager: MatchingManagerProtocol {
    
    private let accountProvider: AccountProviderProtocol
    private let database: MatchingDatabaseProtocol
    private let gameBuilder: GameBuilderProtocol
    
    init(accountProvider: AccountProviderProtocol,
         database: MatchingDatabaseProtocol,
         gameBuilder: GameBuilderProtocol) {
        self.accountProvider = accountProvider
        self.database = database
        self.gameBuilder = gameBuilder
    }
    
    var isLoggedIn: Bool {
        accountProvider.loggedInUserId != nil
    }
    
    func createUser(_ user: WUserInfo) -> Completable {
        database.createUser(user)
    }
    
    func getUser() -> Single<WUserInfo> {
        guard let userId = accountProvider.loggedInUserId else {
            return Single.error(NSError(domain: "Missing user", code: 0))
        }
        return database.getUser(userId)
    }
    
    func observeUserStatus() -> Observable<UserStatus> {
        guard let userId = accountProvider.loggedInUserId else {
            return Observable.error(NSError(domain: "Missing user", code: 0))
        }
        return database.observeUserStatus(userId)
    }
    
    func addToWaitingRoom() -> Completable {
        guard let userId = accountProvider.loggedInUserId else {
            return Completable.error(NSError(domain: "Missing user", code: 0))
        }
        return database.setUserStatus(userId, status: .waiting)
    }
    
    func quitWaitingRoom() -> Completable {
        guard let userId = accountProvider.loggedInUserId else {
            return Completable.error(NSError(domain: "Missing user", code: 0))
        }
        
        return database.setUserStatus(userId, status: .idle)
    }
    
    func quitGame() -> Completable {
        guard let userId = accountProvider.loggedInUserId else {
            return Completable.empty()
        }
        
        return database.setUserStatus(userId, status: .idle)
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
}
*/
