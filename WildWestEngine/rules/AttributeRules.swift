//
//  AttributeRules.swift
//  WildWestEngine
//
//  Created by TELOLAHY Hugues Stéphano on 15/07/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

public enum AttributeRules {
    
    public static func weapon(for player: PlayerProtocol) -> Int {
        player.inPlay.compactMap { $0.attributes[.weapon] as? Int }.max() ?? 1
    }
    
    public static func bangsPerTurn(for player: PlayerProtocol) -> Int {
        ([player] + player.inPlay).compactMap { $0.attributes[.bangsPerTurn] as? Int }.max() ?? 1
    }
    
    public static func maxHealth(for player: PlayerProtocol) -> Int {
        player.attributes[.bullets] as? Int ?? 0
    }
    
    public static func bangsCancelable(for player: PlayerProtocol) -> Int {
        player.attributes[.bangsCancelable] as? Int ?? 1
    }
    
    public static func flippedCards(for player: PlayerProtocol) -> Int {
        player.attributes[.flippedCards] as? Int ?? 1
    }
    
    public static func handLimit(for player: PlayerProtocol) -> Int {
        player.attributes[.handLimit] as? Int ?? player.health
    }
    
}
