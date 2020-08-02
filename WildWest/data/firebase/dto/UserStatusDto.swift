//
//  UserStatusDto.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct UserStatusDto: Codable {
    var waiting: Bool?
    var gameId: String?
    var playerId: String?
}
