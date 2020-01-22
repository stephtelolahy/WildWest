//
//  GameSetupProtocol.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 1/7/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

protocol GameSetupProtocol {
    func roles(for playersCount: Int) -> [Role]
    func setupGame(roles: [Role], figures: [Figure], cards: [CardProtocol]) -> GameStateProtocol
}
