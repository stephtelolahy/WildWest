//
//  Player.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/23/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class Player: PlayerProtocol {
    
    let role: Role?
    let ability: Ability
    let maxHealth: Int
    let imageName: String
    var health: Int
    var hand: [CardProtocol]
    var inPlay: [CardProtocol]
    
    init(role: Role?,
         ability: Ability,
         maxHealth: Int,
         imageName: String,
         health: Int,
         hand: [CardProtocol],
         inPlay: [CardProtocol]) {
        self.role = role
        self.ability = ability
        self.imageName = imageName
        self.maxHealth = maxHealth
        self.health = health
        self.hand = hand
        self.inPlay = inPlay
    }
    
    var identifier: String {
        ability.rawValue
    }
}
