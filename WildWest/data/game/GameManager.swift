//
//  GameManager.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 03/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import RxSwift
import WildWestEngine

protocol GameManagerProtocol {
    func createLocalGame() -> GameEnvironment
    func createRemoteGame(users: [UserInfo])
    func joinRemoteGame(gameId: String, playerId: String) -> Single<GameEnvironment>
}

class GameManager: GameManagerProtocol {
    
    private let database: UserDatabaseProtocol
    private let gameBuilder: GameBuilderProtocol
    private let preferences: UserPreferencesProtocol
    
    private let disposeBag: DisposeBag
    
    init(preferences: UserPreferencesProtocol,
         database: UserDatabaseProtocol,
         gameBuilder: GameBuilderProtocol) {
        self.preferences = preferences
        self.database = database
        self.gameBuilder = gameBuilder
        self.disposeBag = DisposeBag()
    }
    
    func createLocalGame() -> GameEnvironment {
        let state = gameBuilder.createGame(for: preferences.playersCount)
        let playerId = state.playOrder.first
        return gameBuilder.createLocalGameEnvironment(state: state,
                                                      playerId: playerId)
    }
    
    func createRemoteGame(users: [UserInfo]) {
        let state = gameBuilder.createGame(for: users.count)
        let gameId = database.createGameId()
        
        let setUserStatuses: [Completable] = users.enumerated().map { index, user in
            database.setUserStatus(user.id, status: .playing(gameId: gameId, playerId: state.playOrder[index]))
        }
        
        var usersDict: [String: UserInfo] = [:]
        let playerIds = state.playOrder
        for (index, user) in users.enumerated() {
            usersDict[playerIds[index]] = user
        }
        
        database.createGame(id: gameId, state: state)
            .andThen(database.setGameUsers(id: gameId, users: usersDict))
            .andThen(Completable.concat(setUserStatuses))
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    func joinRemoteGame(gameId: String, playerId: String) -> Single<GameEnvironment> {
        Single.zip(database.getGame(gameId), database.getGameUsers(gameId), resultSelector: { [self] state, users in
            gameBuilder.createRemoteGameEnvironment(state: state,
                                                    playerId: playerId,
                                                    gameId: gameId,
                                                    users: users)
        })
    }
}
