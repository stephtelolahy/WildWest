//
//  DeckProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 30/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

protocol DeckProtocol {
    var cards: [CardProtocol] { get }
    var discardPile: [CardProtocol] { get }
    
    func pull() -> CardProtocol
    func addToDiscard(_ card: CardProtocol)
}
