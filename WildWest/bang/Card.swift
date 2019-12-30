//
//  Card.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/23/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct Card: CardProtocol, Decodable {
    
    let name: CardName
    let suit: CardSuit
    let value: String
    
    var identifier: String {
        return "\(name.rawValue)-\(value)-\(suit.rawValue)"
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
