//
//  Card.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/23/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct Card: CardProtocol, Codable {
    
    let name: CardName
    let value: String
    let suit: CardSuit
    let imageName: String
    
    var identifier: String {
        "\(name)-\(value)\(suit.description)"
    }
}

private extension CardSuit {
    var description: String {
        switch self {
        case .clubs:
            return "♣"
            
        case .diamonds:
            return "♦"
            
        case .hearts:
            return "♥"
            
        case .spades:
            return "♠"
        }
    }
}
