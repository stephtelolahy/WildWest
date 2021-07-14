//
//  PlayerProtocol+Extensions.swift
//  WildWestEngine
//
//  Created by TELOLAHY Hugues Stéphano on 13/07/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

public extension PlayerProtocol {
    
    var weapon: Int {
        inPlay.compactMap { $0.attributes[.weapon] as? Int }.max() ?? 1
    }
    
    var bangsPerTurn: Int {
        ([self] + inPlay).compactMap { $0.attributes[.bangsPerTurn] as? Int }.max() ?? 1
    }
    
    var maxHealth: Int {
        attributes[.bullets] as? Int ?? 0
    }
    
    var bangsCancelable: Int {
        attributes[.bangsCancelable] as? Int ?? 1
    }
    
    var flippedCards: Int {
        attributes[.flippedCards] as? Int ?? 1
    }
    
    var handLimit: Int {
        attributes[.handLimit] as? Int ?? health
    }
}
