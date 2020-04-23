//
//  StateDto.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct StateDto: Codable {
    let players: [PlayerDto]
    let deck: [String]
    let discardPile: [String]
    let turn: String
    let generalStore: [String]
    let outcome: String?
    //var challenge: Challenge? { get }
}

struct CardDto: Codable {
    let name: String
    let value: String
    let suit: String
    let imageName: String
}

struct PlayerDto: Codable {
    let identifier: String
    let role: String
    let figureName: String
    let imageName: String
    let description: String
    let abilities: [String: Bool]
    let maxHealth: Int
    let health: Int
    let hand: [String]
    let inPlay: [String]
    let bangsPlayed: Int
    //var lastDamage: DamageEvent? { get }
}
