//
//  EventDto.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 06/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import Foundation

struct EventDto: Codable {
    var timestamp: String = "\(Date().timeIntervalSince1970)"
    var emptyQueue: Bool?
    var flipDeck: Bool?
    var deckToStore: Bool?
    var setPhase: Int?
    var setTurn: String?
    var gainHealth: String?
    var drawDeck: String?
    var drawDeckFlipping: String?
    var drawDiscard: String?
    var removeHit: String?
    var cancelHit: String?
    var gameover: String?
    var run: MoveDto?
    var activate: [MoveDto]?
    var addHit: [HitDto]?
    var play: PlayerCardDto?
    var equip: PlayerCardDto?
    var drawStore: PlayerCardDto?
    var drawDeckChoosing: PlayerCardDto?
    var discardHand: PlayerCardDto?
    var discardInPlay: PlayerCardDto?
    var looseHealth: PlayerOffenderDto?
    var eliminate: PlayerOffenderDto?
    var handicap: PlayerOtherCardDto?
    var drawHand: PlayerOtherCardDto?
    var drawInPlay: PlayerOtherCardDto?
    var passInPlay: PlayerOtherCardDto?
}

struct MoveDto: Codable {
    var ability: String?
    var actor: String?
    var card: PlayCardDto?
    var args: [String: [String]]?
}

struct PlayCardDto: Codable {
    var hand: String?
    var inPlay: String?
}

struct PlayerCardDto: Codable {
    var player: String?
    var card: String?
}

struct PlayerOffenderDto: Codable {
    var player: String?
    var offender: String?
}

struct PlayerOtherCardDto: Codable {
    var player: String?
    var other: String?
    var card: String?
}
