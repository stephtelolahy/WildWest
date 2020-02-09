//
//  PlayerExtension.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 1/2/20.
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
    
    func inPlayCards(named cardName: CardName) -> [CardProtocol] {
        return inPlay.filter { $0.name == cardName }
    }
}
