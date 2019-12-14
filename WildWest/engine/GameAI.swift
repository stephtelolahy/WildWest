//
//  GameAI.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/14/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

protocol GameAIProtocol {
    func choose(_ actions: [GameActionProtocol]) -> GameActionProtocol
}
