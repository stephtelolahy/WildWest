//
//  GameState+Encoding.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Foundation

extension GameStateProtocol {
    func toEncodable() -> StateDto {
        StateDto(players: allPlayers.map { $0.toEncodable() },
                 deck: deck.map { $0.toId() },
                 discardPile: discardPile.map { $0.toId() },
                 turn: turn,
                 generalStore: generalStore.map { $0.toId() },
                 outcome: outcome?.rawValue)
    }
}

extension CardProtocol {
    
    func toId() -> String {
        "\(name)-\(value)-\(suit)"
    }
    
    func toEncodable() -> CardDto {
        CardDto(name: name.rawValue,
                value: value,
                suit: suit.rawValue,
                imageName: imageName)
    }
}

extension PlayerProtocol {
    func toEncodable() -> PlayerDto {
        PlayerDto(identifier: identifier,
                  role: role!.rawValue,
                  figureName: figureName.rawValue,
                  imageName: imageName,
                  description: description,
                  abilities: abilities.toEncodable(),
                  maxHealth: maxHealth,
                  health: health,
                  hand: hand.map { $0.toId() },
                  inPlay: inPlay.map { $0.toId() },
                  bangsPlayed: bangsPlayed)
    }
}

private extension Dictionary where Key == AbilityName, Value == Bool {
    func toEncodable() -> [String: Bool] {
        var result: [String: Bool] = [:]
        self.forEach { key, value in
            result[key.rawValue] = value
        }
        return result
    }
}
