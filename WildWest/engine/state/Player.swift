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
    var hand: [CardProtocol]
    var inPlay: [CardProtocol]
    
    init(role: Role,
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
        return ability.rawValue
    }
    
    func setHealth(_ health: Int) {
        self.health = health
    }
    
    func addHand(_ card: CardProtocol) {
        hand.append(card)
    }
    
    func removeHandById(_ cardId: String) -> CardProtocol? {
        guard let index = hand.firstIndex(where: { $0.identifier == cardId }) else {
            return nil
        }
        
        let card = hand[index]
        hand.remove(at: index)
        return card
    }
    
    func addInPlay(_ card: CardProtocol) {
        inPlay.append(card)
    }
    
    func removeInPlayById(_ cardId: String) -> CardProtocol? {
        guard let index = inPlay.firstIndex(where: { $0.identifier == cardId }) else {
            return nil
        }
        
        let card = inPlay[index]
        inPlay.remove(at: index)
        return card
    }
}
