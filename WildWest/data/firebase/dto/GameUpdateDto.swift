//
//  GameUpdateDto.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 02/05/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Foundation

struct GameUpdateDto: Codable {
    var timestamp: String = "\(Date().timeIntervalSince1970)"
    var setTurn: String?
    var setChallenge: ChallengeDto?
    var removeChallenge: Bool?
    var flipOverFirstDeckCard: Bool?
    var setupGeneralStore: Int?
    var playerPullFromDeck: String?
    var playerPullFromDiscard: String?
    var playerSetBangsPlayed: PlayerSetBangsPlayedDto?
    var playerSetHealth: PlayerSetHealthDto?
    var playerSetDamage: PlayerSetDamageDto?
    var playerDiscardHand: PlayerManipulatesCardDto?
    var playerDiscardTopDeck: PlayerManipulatesCardDto?
    var playerPutInPlay: PlayerManipulatesCardDto?
    var playerDiscardInPlay: PlayerManipulatesCardDto?
    var playerPullFromGeneralStore: PlayerManipulatesCardDto?
    var playerRevealHandCard: PlayerManipulatesCardDto?
    var playerPullFromOtherHand: PlayerManipulatesOtherCardDto?
    var playerPullFromOtherInPlay: PlayerManipulatesOtherCardDto?
    var playerPutInPlayOfOther: PlayerManipulatesOtherCardDto?
    var playerPassInPlayOfOther: PlayerManipulatesOtherCardDto?
}

struct PlayerSetBangsPlayedDto: Codable {
    let playerId: String?
    let count: Int?
}

struct PlayerSetHealthDto: Codable {
    let playerId: String?
    let health: Int?
}

struct PlayerSetDamageDto: Codable {
    let playerId: String?
    let event: DamageEventDto?
}

struct PlayerManipulatesCardDto: Codable {
    let playerId: String?
    let cardId: String?
}

struct PlayerManipulatesOtherCardDto: Codable {
    let playerId: String?
    let otherId: String?
    let cardId: String?
}
