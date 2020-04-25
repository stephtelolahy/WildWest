//
//  DtoEncoder.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class DtoEncoder {
    
    func map(state: GameStateProtocol) -> StateDto {
        StateDto(players: state.allPlayers.map { self.map(player: $0) },
                 deck: state.deck.map { self.map(card: $0) },
                 discardPile: state.discardPile.map { self.map(card: $0) },
                 turn: state.turn,
                 generalStore: state.generalStore.map { self.map(card: $0) },
                 outcome: state.outcome?.rawValue)
    }
}

private extension DtoEncoder {
    
    func map(card: CardProtocol) -> String {
        card.identifier
    }
    
    func map(player: PlayerProtocol) -> PlayerDto {
        PlayerDto(identifier: player.identifier,
                  role: player.role!.rawValue,
                  figureName: player.figureName.rawValue,
                  imageName: player.imageName,
                  description: player.description,
                  abilities: map(abilities: player.abilities),
                  maxHealth: player.maxHealth,
                  health: player.health,
                  hand: player.hand.map { self.map(card: $0) },
                  inPlay: player.inPlay.map { self.map(card: $0) },
                  bangsPlayed: player.bangsPlayed)
    }
    
    func map(abilities: [AbilityName: Bool]) -> [String: Bool] {
        var result: [String: Bool] = [:]
        abilities.forEach { key, value in
            result[key.rawValue] = value
        }
        return result
    }
}
