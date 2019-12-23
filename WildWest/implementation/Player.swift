//
//  Player.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/23/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class Player: PlayerProtocol {
    
    let role: Role
    let ability: Ability
    let maxHealth: Int
    var health: Int
    let hand: CardListProtocol
    let inPlay: CardListProtocol
    
    init(role: Role, ability: Ability, maxHealth: Int, health: Int, hand: CardListProtocol, inPlay: CardListProtocol) {
        self.role = role
        self.ability = ability
        self.maxHealth = maxHealth
        self.health = health
        self.hand = hand
        self.inPlay = inPlay
    }
    
    var identifier: String {
        return "\(ability)-\(role)"
    }
    
    func gainLifePoint() {
        health += 1
    }
    
}
