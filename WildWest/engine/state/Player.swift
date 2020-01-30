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
    let imageName: String
    var health: Int
    let hand: CardListProtocol
    let inPlay: CardListProtocol
    var actions: [ActionProtocol]
    
    init(role: Role,
         figure: Figure,
         maxHealth: Int,
         health: Int,
         hand: CardListProtocol,
         inPlay: CardListProtocol,
         actions: [ActionProtocol]) {
        self.role = role
        self.ability = figure.ability
        self.imageName = figure.imageName
        self.maxHealth = maxHealth
        self.health = health
        self.hand = hand
        self.inPlay = inPlay
        self.actions = actions
    }
    
    var identifier: String {
        return ability.rawValue
    }
    
    func setHealth(_ health: Int) {
        self.health = health
    }
    
    func setActions(_ actions: [ActionProtocol]) {
        self.actions = actions
    }
}
