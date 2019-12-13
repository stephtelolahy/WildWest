//
//  GameRules.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/14/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

protocol GameRulesProtocol {
    func isOver(_ game: Game) -> Bool
    func possibleActions(_ game: Game) -> [Action]
}

class BangRules: GameRulesProtocol {
    
    func isOver(_ game: Game) -> Bool {
        return true
    }
    
    func possibleActions(_ game: Game) -> [Action] {
        return []
    }
}
