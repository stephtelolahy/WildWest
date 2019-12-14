//
//  GameAction.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/13/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

/// An action choosen by the player
protocol GameAction {
    func isAllowed() -> Bool
    func execute(_ game: Game) -> Game
    func undo(_ game: Game) -> Game
}
