//
//  GameUpdate.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/14/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

/// Elementary game update
protocol GameUpdate {
    func apply(to game: Game) -> Game
}
