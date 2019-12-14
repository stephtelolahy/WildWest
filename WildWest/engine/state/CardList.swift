//
//  CardList.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/14/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

protocol CardListProtocol {
    var cards: [Card] { get }
    
    func addCard(_ card: Card)
    func removeCard(_ identifier: Card)
    func pull() -> Card
}
