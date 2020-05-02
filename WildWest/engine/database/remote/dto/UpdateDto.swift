//
//  UpdateDto.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 02/05/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Foundation

struct UpdateDto: Codable {
    var setTurn: String?
    var setChallenge: ChallengeDto?
    var flipOverFirstDeckCard: Bool?
    var setupGeneralStore: Int?
    var playerPullFromDeck: String?
    var playerSetBangsPlayed: PlayerSetBangsPlayedDto?
    var playerGainHealth: PlayerGainHealthDto?
    var playerLooseHealth: PlayerLooseHealthDto?
    var playerDiscardHand: PlayerManipulatesCardDto?
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

struct PlayerGainHealthDto: Codable {
    let playerId: String?
    let health: Int?
}

struct PlayerLooseHealthDto: Codable {
    let playerId: String?
    let health: Int?
    let damageEvent: DamageEventDto?
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
