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
}
