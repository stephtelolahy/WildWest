//
//  Player+Cards.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 29/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension PlayerProtocol {
    
    func handCards(named cardName: CardName) -> [CardProtocol]? {
        let cards = hand.filter { $0.name == cardName }
        guard !cards.isEmpty else {
            return nil
        }
        
        return cards
    }
    
    func inPlayCards(named cardName: CardName) -> [CardProtocol]? {
        let cards = inPlay.filter { $0.name == cardName }
        guard !cards.isEmpty else {
            return nil
        }
        
        return cards
    }
    
    func handCard(_ cardId: String?) -> CardProtocol? {
        hand.first(where: { $0.identifier == cardId })
    }
    
    func inPlayCard(_ cardId: String?) -> CardProtocol? {
        inPlay.first(where: { $0.identifier == cardId })
    }
}
