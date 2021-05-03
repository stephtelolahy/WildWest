//
//  PlayerDto.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Foundation

struct PlayerDto: Codable {
    let identifier: String?
    let name: String?
    let desc: String?
    let abilities: [String: Int]?
    let role: String?
    let maxHealth: Int?
    let health: Int?
    let hand: [String: String]?
    let inPlay: [String: String]?
}
