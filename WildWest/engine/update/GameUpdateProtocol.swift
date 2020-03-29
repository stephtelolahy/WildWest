//
//  GameUpdateProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 09/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

enum GameUpdate: Equatable {
    case setTurn(String)
    case setChallenge(Challenge?)
    case flipOverFirstDeckCard
    case eliminatePlayer(String)
    case playerGainHealth(String, Int)
    case playerLooseHealth(String, Int, DamageSource)
    case playerPullFromDeck(String, Int)
    case playerDiscardHand(String, String)
    case playerPutInPlay(String, String)
    case playerDiscardInPlay(String, String)
    case playerPullFromOtherHand(String, String, String)
    case playerPullFromOtherInPlay(String, String, String)
    case playerPutInPlayOfOther(String, String, String)
    case playerPassInPlayOfOther(String, String, String)
    case playerPullFromGeneralStore(String, String)
    case setupGeneralStore(Int)
}

// Define database transaction on executing a GameUpdate
protocol UpdateExecutorProtocol {
    func execute(_ update: GameUpdate, in database: GameDatabaseProtocol)
}
