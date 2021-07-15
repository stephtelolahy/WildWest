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
                 hits: encode(hits: state.hits),
                 played: encode(abilities: state.played),
                 winner: encode(winner: state.winner))
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
               hits: try decode(hits: state.hits),
               played: try decode(abilities: state.played),
               history: [],
               winner: decode(winner: state.winner))
    }
    
    func encode(hit: HitProtocol) -> HitDto {
        HitDto(player: hit.player,
               name: hit.name,
               abilities: hit.abilities,
               cancelable: hit.cancelable,
               offender: hit.offender,
               target: hit.target)
    }
    
    func decode(hit: HitDto) throws -> HitProtocol {
        try GHit(player: hit.player.unwrap(),
                 name: hit.name.unwrap(),
                 abilities: hit.abilities.unwrap(),
                 offender: hit.offender.unwrap(),
                 cancelable: hit.cancelable.unwrap(),
                 target: hit.target)
    }
}

private extension DtoEncoder {
    
    func encode(hits: [HitProtocol]) -> [String: HitDto] {
        hits.reduce([String: HitDto]()) { dict, hit in
            var dict = dict
            let key = self.databaseRef.childByAutoIdKey()
            dict[key] = encode(hit: hit)
            return dict
        }
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
                  attributes: encode(attributes: player.attributes),
                  abilities: Array(player.abilities),
                  role: player.role?.rawValue,
                  health: player.health,
                  hand: encode(cards: player.hand),
                  inPlay: encode(cards: player.inPlay))
    }
    
    func decode(player: PlayerDto) throws -> PlayerProtocol {
        GPlayer(identifier: try player.identifier.unwrap(),
                name: try player.name.unwrap(),
                desc: try player.desc.unwrap(),
                attributes: try decode(attributes: player.attributes),
                abilities: Set(try player.abilities.unwrap()),
                role: try Role(rawValue: try player.role.unwrap()).unwrap(),
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
    
    func encode(attributes: [CardAttributeKey: Any]) -> String? {
        let dict: [String: Any] = attributes.reduce(into: [:]) { result, element in
            result[element.key.rawValue] = element.value
        }
        guard let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []),
              let jsonString = String(data: jsonData, encoding: String.Encoding.ascii) else {
            return nil
        }
        return jsonString
    }
    
    func decode(attributes: String?) throws -> [CardAttributeKey: Any] {
        guard let data = attributes?.data(using: .utf8),
              let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return [:]
        }
        return dict.reduce(into: [:]) { result, element in
            result[CardAttributeKey(rawValue: element.key)!] = element.value
        }
    }
    
    func encode(winner: Role?) -> String? {
        winner?.rawValue
    }
    
    func decode(winner: String?) -> Role? {
        guard let rawValue = winner else {
            return nil
        }
        
        return Role(rawValue: rawValue)
    }
}
