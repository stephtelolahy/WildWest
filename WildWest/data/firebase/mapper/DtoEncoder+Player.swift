//
//  DtoEncoder+Player.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
/*
import Foundation

extension DtoEncoder {
    
    func encode(player: PlayerProtocol, index: Int) -> PlayerDto {
        PlayerDto(identifier: player.identifier,
                  index: index,
                  role: player.role!.rawValue,
                  figureName: player.figureName.rawValue,
                  imageName: player.imageName,
                  description: player.description,
                  abilities: encode(abilities: player.abilities),
                  maxHealth: player.maxHealth,
                  health: player.health,
                  hand: encode(cards: player.hand),
                  inPlay: encode(cards: player.inPlay),
                  bangsPlayed: player.bangsPlayed,
                  lastDamage: encode(damageEvent: player.lastDamage))
    }
    
    func decode(player: PlayerDto) throws -> PlayerProtocol {
        Player(identifier: try player.identifier.unwrap(),
               role: try Role(rawValue: try player.role.unwrap()).unwrap(),
               figureName: try FigureName(rawValue: try player.figureName.unwrap()).unwrap(),
               imageName: try player.imageName.unwrap(),
               description: try player.description.unwrap(),
               abilities: try decode(abilities: player.abilities),
               maxHealth: try player.maxHealth.unwrap(),
               health: try player.health.unwrap(),
               hand: try decode(cards: player.hand),
               inPlay: try decode(cards: player.inPlay),
               bangsPlayed: try player.bangsPlayed.unwrap(),
               lastDamage: try decode(damageEvent: player.lastDamage))
    }
    
    func encode(damageEvent: DamageEvent?) -> DamageEventDto? {
        guard let damageEvent = damageEvent else {
            return nil
        }
        
        return DamageEventDto(damage: damageEvent.damage,
                              source: encode(damageSource: damageEvent.source))
        
    }
    
    func decode(damageEvent: DamageEventDto?) throws -> DamageEvent? {
        guard let damageEvent = damageEvent else {
            return nil
        }
        
        return DamageEvent(damage: try damageEvent.damage.unwrap(),
                           source: try decode(damageSource: try damageEvent.source.unwrap()))
    }
}

private extension DtoEncoder {
    
    func encode(abilities: [AbilityName: Bool]) -> [String: Bool] {
        var result: [String: Bool] = [:]
        abilities.forEach { key, value in
            result[key.rawValue] = value
        }
        return result
    }
    
    func decode(abilities: [String: Bool]?) throws -> [AbilityName: Bool] {
        guard let abilities = abilities else {
            return [:]
        }
        
        var result: [AbilityName: Bool] = [:]
        try abilities.forEach { key, value in
            let ability = try AbilityName(rawValue: key).unwrap()
            result[ability] = value
        }
        return result
    }
    
    func encode(damageSource: DamageSource) -> DamageSourceDto? {
        switch damageSource {
        case .byDynamite:
            return DamageSourceDto(byDynamite: true)
            
        case let .byPlayer(playerId):
            return DamageSourceDto(byPlayer: playerId)
        }
    }
    
    func decode(damageSource: DamageSourceDto) throws -> DamageSource {
        if damageSource.byDynamite == true {
            return .byDynamite
        }
        
        if let playerId = damageSource.byPlayer {
            return .byPlayer(playerId)
        }
        
        throw NSError(domain: "invalid DamageSourceDto", code: 0)
    }
}
*/
