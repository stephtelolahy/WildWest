//
//  DtoEncoder+State.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
/*
extension DtoEncoder {
    
    func encode(state: GameStateProtocol) -> GameStateDto {
        GameStateDto(players: encode(players: state.allPlayers),
                     deck: encode(orderedCards: state.deck),
                     discardPile: encode(orderedCards: state.discardPile.reversed()),
                     turn: state.turn,
                     generalStore: encode(cards: state.generalStore),
                     outcome: encode(outcome: state.outcome),
                     challenge: encode(challenge: state.challenge))
    }
    
    func decode(state: GameStateDto) throws -> GameStateProtocol {
        GameState(allPlayers: try decode(players: state.players),
                  deck: try decode(orderedCards: state.deck),
                  discardPile: try decode(orderedCards: state.discardPile).reversed(),
                  turn: try state.turn.unwrap(),
                  challenge: try decode(challenge: state.challenge),
                  generalStore: try decode(cards: state.generalStore),
                  outcome: try decode(outcome: state.outcome))
    }
}

private extension DtoEncoder {
    
    func encode(players: [PlayerProtocol]) -> [String: PlayerDto] {
        var result: [String: PlayerDto] = [:]
        for (index, player) in players.enumerated() {
            let dto = encode(player: player, index: index)
            result[player.identifier] = dto
        }
        return result
    }
    
    func decode(players: [String: PlayerDto]?) throws -> [PlayerProtocol] {
        let playerDtos = Array(try players.unwrap().values)
        
        return try playerDtos
            .sorted(by: { ($0.index ?? 0) < ($1.index ?? 0) })
            .map { try self.decode(player: $0) }
        
    }
    
    func encode(outcome: GameOutcome?) -> String? {
        outcome?.rawValue
    }
    
    func decode(outcome: String?) throws -> GameOutcome? {
        guard let outcome = outcome else {
            return nil
        }
        
        return try GameOutcome(rawValue: outcome).unwrap()
    }
}
*/
