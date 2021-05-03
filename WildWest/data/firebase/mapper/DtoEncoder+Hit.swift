//
//  DtoEncoder+Hit.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 03/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import WildWestEngine

extension DtoEncoder {
    
    func encode(hit: HitProtocol) -> HitDto {
        HitDto(name: hit.name,
               abilities: hit.abilities,
               player: hit.player,
               offender: hit.offender,
               cancelable: hit.cancelable)
    }
    
    func decode(hit: HitDto) throws -> HitProtocol {
        try GHit(name: hit.name.unwrap(),
                 player: hit.player.unwrap(),
                 abilities: hit.abilities.unwrap(),
                 cancelable: hit.cancelable.unwrap(),
                 offender: hit.offender.unwrap())
    }
}
