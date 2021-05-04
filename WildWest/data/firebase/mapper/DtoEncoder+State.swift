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
    
    func decode(state: GameStateDto) throws -> StateProtocol {
        GState(players: try state.players?.mapValues({ try decode(player: $0) }) ?? [:],
               initialOrder: try state.initialOrder.unwrap(),
               playOrder: try state.playOrder.unwrap(),
               turn: try state.turn.unwrap(),
               phase: try state.phase.unwrap(),
               deck: try decode(cards: state.deck),
               discard: try decode(cards: state.discard).reversed(),
               store: try decode(cards: state.store),
               storeView: state.storeView,
               hits: try state.hits?.map({ try decode(hit: $0) }) ?? [],
               played: state.played ?? [])
    }
}
