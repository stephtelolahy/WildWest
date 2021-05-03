//
//  GameStateDto.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct GameStateDto: Codable {
    let players: [String: PlayerDto]?
    let initialOrder: [String]?
    let playOrder: [String]?
    let turn: String?
    let phase: Int?
    let deck: [String: String]?
    let discard: [String: String]?
    let store: [String: String]?
    let storeView: String?
    let hits: [HitDto]?
    let played: [String]?
}

struct HitDto: Codable {
    let name: String?
    let abilities: [String]?
    let player: String?
    let offender: String?
    let cancelable: Int?
}
