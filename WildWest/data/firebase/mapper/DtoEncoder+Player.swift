//
//  DtoEncoder+Player.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Foundation
import WildWestEngine

extension DtoEncoder {
    
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
}
