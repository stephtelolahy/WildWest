//
//  GameSetupProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 30/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

protocol GameSetupProtocol {
    func roles(for playersCount: Int) -> [Role]
    func setupGame(roles: [Role], figures: [Figure], cards: [CardProtocol]) -> GameStateProtocol
}
