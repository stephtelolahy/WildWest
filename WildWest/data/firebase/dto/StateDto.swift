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
    let storeView: String?
    let hits: [String: HitDto]?
    let played: [String: String]?
}

struct HitDto: Codable, Equatable {
    let name: String?
    let player: String?
    let abilities: [String]?
    let offender: String?
    let cancelable: Int?
}

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

