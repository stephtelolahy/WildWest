//
//  PlayerExtension.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 1/2/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension PlayerProtocol {
    
    func handCards(named names: CardName...) -> [CardProtocol] {
        return hand.cards.filter({ names.contains($0.name) })
    }
}
