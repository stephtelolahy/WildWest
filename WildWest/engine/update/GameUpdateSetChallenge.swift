//
//  GameUpdateSetChallenge.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 28/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct GameUpdateSetChallenge: GameUpdateProtocol {
    let challenge: Challenge?
    
    var description: String {
        "setChallenge \(challenge?.description ?? "nil")"
    }
    
    func execute(in database: GameDatabaseProtocol) {
        database.setChallenge(challenge)
        if case let .shoot(_, cardName, _) = challenge {
            if case .bang = cardName {
                database.setBangsPlayed(database.state.bangsPlayed + 1)
            }
            database.setBarrelsResolved(0)
        }
    }
}
