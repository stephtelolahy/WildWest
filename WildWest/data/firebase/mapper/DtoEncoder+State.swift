//
//  DtoEncoder+State.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import WildWestEngine

extension DtoEncoder {
    
    func encode(state: StateProtocol) -> GameStateDto {
        GameStateDto(players: state.players.mapValues { encode(player: $0) },
                     initialOrder: state.initialOrder,
                     playOrder: state.playOrder,
                     turn: state.turn,
                     phase: state.phase,
                     deck: encode(cards: state.deck),
                     discard: encode(cards: state.discard.reversed()),
                     store: encode(cards: state.store),
                     storeView: state.storeView,
                     hits: state.hits.map { encode(hit: $0) },
                     played: state.played)
    }
    /*
    func decode(state: GameStateDto) throws -> GameStateProtocol {
        GameState(allPlayers: try decode(players: state.players),
                  deck: try decode(orderedCards: state.deck),
                  discardPile: try decode(orderedCards: state.discardPile).reversed(),
                  turn: try state.turn.unwrap(),
                  challenge: try decode(challenge: state.challenge),
                  generalStore: try decode(cards: state.generalStore),
                  outcome: try decode(outcome: state.outcome))
    }
 */
}

private extension DtoEncoder {
    
    /*
    func decode(players: [String: PlayerDto]?) throws -> [PlayerProtocol] {
        let playerDtos = Array(try players.unwrap().values)
        
        return try playerDtos
            .sorted(by: { ($0.index ?? 0) < ($1.index ?? 0) })
            .map { try self.decode(player: $0) }
        
    }
 */
}
