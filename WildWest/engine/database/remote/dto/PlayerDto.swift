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
    let role: String?
    let figureName: String?
    let imageName: String?
    let description: String?
    let abilities: [String: Bool]?
    let maxHealth: Int?
    let health: Int?
    let hand: [String: Bool]?
    let inPlay: [String: Bool]?
    let bangsPlayed: Int?
    let lastDamage: DamageEventDto?
}

struct DamageEventDto: Codable {
    let damage: Int?
    let source: DamageSourceDto?
}

struct DamageSourceDto: Codable {
    var byDynamite: Bool?
    var byPlayer: String?
}
