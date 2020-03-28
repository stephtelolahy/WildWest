//
//  RangeCalculatorProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 01/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

protocol RangeCalculatorProtocol {
    func distance(from playerId: String, to otherId: String, in state: GameStateProtocol) -> Int
    func reachableDistance(of player: PlayerProtocol) -> Int
}
