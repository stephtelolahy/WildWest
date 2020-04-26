//
//  StateDto.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct StateDto: Codable {
    let players: [PlayerDto]?
    let deck: [String]?
    let discardPile: [String]?
    let turn: String?
    let generalStore: [String]?
    let outcome: String?
    let challenge: ChallengeDto?
}

struct ChallengeDto: Codable {
    let name: String?
    let targetIds: [String]?
    let damage: Int?
    let counterNeeded: Int?
    let barrelsPlayed: Int?
}
