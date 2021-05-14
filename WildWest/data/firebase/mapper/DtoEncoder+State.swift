//
//  DtoEncoder+State.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import WildWestEngine

extension DtoEncoder {
    
    func encode(state: StateProtocol) -> StateDto {
        StateDto(players: state.players.mapValues { encode(player: $0) },
                 initialOrder: state.initialOrder,
                 playOrder: state.playOrder,
                 turn: state.turn,
                 phase: state.phase,
                 deck: encode(cards: state.deck),
                 discard: encode(cards: state.discard.reversed()),
                 store: encode(cards: state.store),
                 storeView: state.storeView,
                 hits: encode(hits: state.hits),
                 played: encode(abilities: state.played))
    }
    
    func decode(state: StateDto) throws -> StateProtocol {
        GState(players: try state.players?.mapValues({ try decode(player: $0) }) ?? [:],
               initialOrder: try state.initialOrder.unwrap(),
               playOrder: try state.playOrder.unwrap(),
               turn: try state.turn.unwrap(),
               phase: try state.phase.unwrap(),
               deck: try decode(cards: state.deck),
               discard: try decode(cards: state.discard).reversed(),
               store: try decode(cards: state.store),
               storeView: state.storeView,
               hits: try decode(hits: state.hits),
               played: try decode(abilities: state.played))
    }
}

private extension DtoEncoder {
    
    func encode(hit: HitProtocol) -> HitDto {
        HitDto(name: hit.name,
               player: hit.player,
               abilities: hit.abilities,
               offender: hit.offender,
               cancelable: hit.cancelable)
    }
    
    func encode(hits: [HitProtocol]) -> [String: HitDto] {
        hits.reduce([String: HitDto]()) { dict, hit in
            var dict = dict
            let key = self.databaseRef.childByAutoIdKey()
            dict[key] = encode(hit: hit)
            return dict
        }
    }
    
    func decode(hit: HitDto) throws -> HitProtocol {
        try GHit(name: hit.name.unwrap(),
                 player: hit.player.unwrap(),
                 abilities: hit.abilities.unwrap(),
                 cancelable: hit.cancelable.unwrap(),
                 offender: hit.offender.unwrap())
    }
    
    func decode(hits: [String: HitDto]?) throws -> [HitProtocol] {
        guard let hits = hits else {
            return []
        }
        
        let orderedKeys = hits.keys.sorted()
        return try orderedKeys.map { try decode(hit: hits[$0].unwrap()) }
    }
    
    func encode(player: PlayerProtocol) -> PlayerDto {
        PlayerDto(identifier: player.identifier,
                  name: player.name,
                  desc: player.desc,
                  abilities: player.abilities,
                  role: player.role?.rawValue,
                  maxHealth: player.maxHealth,
                  health: player.health,
                  hand: encode(cards: player.hand),
                  inPlay: encode(cards: player.inPlay))
    }
    
    func decode(player: PlayerDto) throws -> PlayerProtocol {
        GPlayer(identifier: try player.identifier.unwrap(),
                name: try player.name.unwrap(),
                desc: try player.desc.unwrap(),
                abilities: try player.abilities.unwrap(),
                role: try Role(rawValue: try player.role.unwrap()).unwrap(),
                maxHealth: try player.maxHealth.unwrap(),
                health: try player.health.unwrap(),
                hand: try decode(cards: player.hand),
                inPlay: try decode(cards: player.inPlay))
    }
    
    func encode(abilities: [String]) -> [String: String] {
        abilities.reduce([String: String]()) { dict, ability in
            var dict = dict
            dict[self.databaseRef.childByAutoIdKey()] = ability
            return dict
        }
    }
    
    func decode(abilities: [String: String]?) throws -> [String] {
        guard let abilities = abilities else {
            return []
        }
        
        return Array(abilities.values)
    }
}
