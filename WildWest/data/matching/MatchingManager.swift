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
    var currentUser: WUserInfo { get }
    
    func createUser() -> Completable
    func observeUserStatus() -> Observable<UserStatus>
    func addToWaitingRoom() -> Completable
    func quitWaitingRoom() -> Completable
    func quitGame() -> Completable
    func observeWaitingUsers() -> Observable<[WUserInfo]>
    func createGame(users: [WUserInfo]) -> Completable
}

class MatchingManager: MatchingManagerProtocol {
    
    private let database: MatchingDatabaseProtocol
    
    init(database: MatchingDatabaseProtocol) {
        self.database = database
    }
    
    var currentUser: WUserInfo {
        guard let user = Auth.auth().currentUser else {
            fatalError("Missing user")
        }
        
        return WUserInfo(id: user.uid,
                         name: user.displayName ?? "",
                         photoUrl: user.photoURL?.absoluteString ?? "")
    }
    
    func createUser() -> Completable {
        database.createUser(currentUser)
    }
    
    func observeUserStatus() -> Observable<UserStatus> {
        database.observeUserStatus(currentUser.id)
    }
    
    func addToWaitingRoom() -> Completable {
        database.setUserStatus(currentUser.id, status: .waiting)
    }
    
    func quitWaitingRoom() -> Completable {
        database.setUserStatus(currentUser.id, status: .idle)
    }
    
    func quitGame() -> Completable {
        database.setUserStatus(currentUser.id, status: .idle)
    }
    
    func observeWaitingUsers() -> Observable<[WUserInfo]> {
        database.observeWaitingUsers()
    }
    
    func createGame(users: [WUserInfo]) -> Completable {
        let state = GameBuilder().createGame(for: users.count,
                                             preferredFigure: AppModules.shared.userPreferences.preferredFigure)
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
}
