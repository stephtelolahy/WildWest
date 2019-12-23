//
//  Card.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/23/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class Card: CardProtocol {
    
    let name: CardName
    let suits: CardSuit
    let value: String
    
    init(name: CardName, suits: CardSuit, value: String) {
        self.name = name
        self.suits = suits
        self.value = value
    }
    
    var identifier: String {
        return "\(name.rawValue)-\(value)-\(suits.rawValue)"
    }
    
    var type: CardType {
        switch name {
        case .colt45, .volcanic, .schofield, .remington, .winchester, .revCarbine:
            return .gun
            
        case .barrel, .mustang, .scope, .dynamite, .jail:
            return .item
            
        default:
            return .play
        }
    }
}
