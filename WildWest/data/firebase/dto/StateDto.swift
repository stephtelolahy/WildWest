//
//  StateDto.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct StateDto: Codable {
    let players: [String: PlayerDto]?
    let initialOrder: [String]?
    let playOrder: [String]?
    let turn: String?
    let phase: Int?
    let deck: [String: String]?
    let discard: [String: String]?
    let store: [String: String]?
    let hit: HitDto?
    let played: [String: String]?
    let winner: String?
}

struct HitDto: Codable, Equatable {
    let name: String?
    let players: [String]?
    let abilities: [String]?
    let cancelable: Int?
    let targets: [String]?
}

struct PlayerDto: Codable {
    let identifier: String?
    let name: String?
    let desc: String?
    let attributes: String?
    let abilities: [String]?
    let role: String?
    let health: Int?
    let hand: [String: String]?
    let inPlay: [String: String]?
}
