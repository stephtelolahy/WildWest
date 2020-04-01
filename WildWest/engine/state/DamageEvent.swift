//
//  DamageEvent.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 30/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct DamageEvent: Equatable {
    let playerId: String
    let source: DamageSource
}

enum DamageSource: Equatable {
    case byDynamite
    case byPlayer(String)
}
