//
//  GameRenderer.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/14/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

protocol GameRendererProtocol {
    func render(_ game: Game)
}

class ConsoleRenderer: GameRendererProtocol {
    func render(_ game: Game) {
        print(game)
    }
}
