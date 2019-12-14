//
//  GameUpdate.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/14/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

protocol GameUpdateProtocol {
    func apply(to game: GameStateProtocol)
}
