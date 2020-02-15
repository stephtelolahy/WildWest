//
//  AIProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 15/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

/// Agent able to play itself
protocol AIProtocol {
    func chooseCommand(in state: GameStateProtocol) -> ActionProtocol?
}
