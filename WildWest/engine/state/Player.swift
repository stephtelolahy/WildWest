//
//  Player.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/23/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class Player: PlayerProtocol {
    
    let role: Role?
    let figure: FigureProtocol
    let maxHealth: Int
    var health: Int
    var hand: [CardProtocol]
    var inPlay: [CardProtocol]
    
    init(role: Role?,
         figure: FigureProtocol,
         maxHealth: Int,
         health: Int,
         hand: [CardProtocol],
         inPlay: [CardProtocol]) {
        self.role = role
        self.figure = figure
        self.maxHealth = maxHealth
        self.health = health
        self.hand = hand
        self.inPlay = inPlay
    }
    
    var identifier: String {
        figure.ability.rawValue
    }
}
