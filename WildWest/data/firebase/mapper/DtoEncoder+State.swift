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
                 hit: encode(hit: state.hit),
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
               hit: try decode(hit: state.hit),
               played: try decode(abilities: state.played),
               history: [],
               winner: decode(winner: state.winner))
    }
    
    func encode(hit: HitProtocol?) -> HitDto? {
        guard let hit = hit else {
            return nil
        }
        
        return HitDto(name: hit.name,
                      players: hit.players,
                      abilities: hit.abilities,
                      cancelable: hit.cancelable,
                      targets: hit.targets)
    }
    
    func decode(hit: HitDto?) throws -> GHit? {
        guard let hit = hit else {
            return nil
        }
        
        return try GHit(name: hit.name.unwrap(),
                        players: hit.players.unwrap(),
                        abilities: hit.abilities.unwrap(),
                        cancelable: hit.cancelable.unwrap(),
                        targets: hit.targets ?? [])
    }
}

private extension DtoEncoder {
    
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
