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
    let hits: [String: HitDto]?
    let played: [String: String]?
}

struct HitDto: Codable, Equatable {
    let player: String?
    let name: String?
    let abilities: [String]?
    let cancelable: Int?
    let offender: String?
    let target: String?
}

struct PlayerDto: Codable {
    let identifier: String?
    let name: String?
    let desc: String?
    let abilities: [String]?
    let attributes: CardAttributesDto?
    let role: String?
    let maxHealth: Int?
    let health: Int?
    let hand: [String: String]?
    let inPlay: [String: String]?
}

struct CardAttributesDto: Codable {
    let bullets: Int?
    let mustang: Int?
    let scope: Int?
    let weapon: Int?
    let flippedCards: Int?
    let bangsCancelable: Int?
    let bangsPerTurn: Int?
    let handLimit: Int?
    let silentCard: String?
    let silentAbility: String?
    let playAs: [String: String]?
}
