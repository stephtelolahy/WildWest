//
//  Player.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/23/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class Player: PlayerProtocol {
    
    let identifier: String
    let role: Role?
    let figureName: FigureName
    let imageName: String
    let description: String
    let abilities: [AbilityName: Bool]
    let maxHealth: Int
    var health: Int
    var hand: [CardProtocol]
    var inPlay: [CardProtocol]
    var bangsPlayed: Int
    var lastDamage: DamageEvent?
    
    init(identifier: String,
         role: Role?,
         figureName: FigureName,
         imageName: String,
         description: String,
         abilities: [AbilityName: Bool],
         maxHealth: Int,
         health: Int,
         hand: [CardProtocol],
         inPlay: [CardProtocol],
         bangsPlayed: Int,
         lastDamage: DamageEvent?) {
        self.identifier = identifier
        self.role = role
        self.figureName = figureName
        self.imageName = imageName
        self.description = description
        self.abilities = abilities
        self.maxHealth = maxHealth
        self.health = health
        self.hand = hand
        self.inPlay = inPlay
        self.bangsPlayed = bangsPlayed
        self.lastDamage = lastDamage
    }
}
