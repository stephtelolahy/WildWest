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
    /*
     case activate(moves: [GMove])
     case run(move: GMove)
     
     case play(player: String, card: String)
     case equip(player: String, card: String)
     case handicap(player: String, card: String, other: String)
     
     case setTurn(player: String)
     case setPhase(value: Int)

     case gainHealth(player: String)
     case looseHealth(player: String, offender: String)
     case eliminate(player: String, offender: String)
     
     case drawDeck(player: String)
     case drawHand(player: String, other: String, card: String)
     case drawInPlay(player: String, other: String, card: String)
     case drawStore(player: String, card: String)
     case drawDiscard(player: String)
     
     case discardHand(player: String, card: String)
     case discardInPlay(player: String, card: String)
     case passInPlay(player: String, card: String, other: String)

     case setStoreView(player: String?)
     case deckToStore
     case storeToDeck(card: String)
     
     case revealDeck
     case revealHand(player: String, card: String)

     case addHit(name: String, player: String, abilities: [String], cancelable: Int, offender: String)
     case removeHit(player: String)
     case cancelHit(player: String)
     
     case gameover(winner: Role)
     case emptyQueue
     */
}

/*
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
 */

/*
 struct GameMoveDto: Codable {
     var timestamp: String = "\(Date().timeIntervalSince1970)"
     let name: String?
     let actorId: String?
     let cardId: String?
     let targetId: String?
     let targetCard: TargetCardDto?
     var discardIds: [String]?
 }

 struct TargetCardDto: Codable {
     let ownerId: String?
     let source: TargetCardSourceDto?
 }

 struct TargetCardSourceDto: Codable {
     var randomHand: Bool?
     var inPlay: String?
 }

 */
