//
//  CardList.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/14/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

protocol CardListProtocol {
    var cards: [CardProtocol] { get }
    
    func addCard(_ card: CardProtocol)
    func removeCard(_ identifier: CardProtocol)
    func pull() -> CardProtocol
}
