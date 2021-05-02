//
//  UserStatus.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

enum UserStatus: Equatable {
    case playing(gameId: String, playerId: String)
    case waiting
    case idle
}
