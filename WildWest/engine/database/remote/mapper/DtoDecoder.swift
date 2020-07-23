//
//  DtoDecoder.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable function_body_length
// swiftlint:disable cyclomatic_complexity
// swiftlint:disable type_body_length

import Foundation

class DtoDecoder {
    
    private let allCards: [CardProtocol]
    
    init(allCards: [CardProtocol]) {
        self.allCards = allCards
    }
    
    func decode(state: GameStateDto) throws -> GameStateProtocol {
        GameState(allPlayers: try decode(players: state.players),
                  deck: try decode(orderedCards: state.deck),
                  discardPile: try decode(orderedCards: state.discardPile).reversed(),
                  turn: try state.turn.unwrap(),
                  challenge: try decode(challenge: state.challenge),
                  generalStore: try decode(cards: state.generalStore),
                  outcome: try decode(outcome: state.outcome))
    }
    
    func decode(card: String) throws -> CardProtocol {
        try allCards.first(where: { $0.identifier == card }).unwrap()
    }
    
    func decode(move: GameMoveDto) throws -> GameMove {
        GameMove(name: MoveName(try move.name.unwrap()),
                 actorId: try move.actorId.unwrap(),
                 cardId: move.cardId,
                 targetId: move.targetId,
                 targetCard: try decode(targetCard: move.targetCard),
                 discardIds: move.discardIds)
    }
    
    func decode(update: GameUpdateDto) throws -> GameUpdate {
        if let turn = update.setTurn {
            return .setTurn(turn)
        }
        
        if let arg = update.setChallenge,
            let challenge = try decode(challenge: arg) {
            return .setChallenge(challenge)
        }
        
        if update.removeChallenge == true {
            return .setChallenge(nil)
        }
        
        if update.flipOverFirstDeckCard == true {
            return .flipOverFirstDeckCard
        }
        
        if let cardsCount = update.setupGeneralStore {
            return .setupGeneralStore(cardsCount)
        }
        
        if let playerId = update.playerPullFromDeck {
            return .playerPullFromDeck(playerId)
        }
        
        if let arg = update.playerSetBangsPlayed,
            let playerId = arg.playerId,
            let count = arg.count {
            return .playerSetBangsPlayed(playerId, count)
        }
        
        if let arg = update.playerSetHealth,
            let playerId = arg.playerId,
            let health = arg.health {
            return .playerSetHealth(playerId, health)
        }
        
        if let arg = update.playerSetDamage,
            let playerId = arg.playerId,
            let eventDto = arg.event,
            let event = try decode(damageEvent: eventDto) {
            return .playerSetDamage(playerId, event)
        }
        
        if let arg = update.playerDiscardHand,
            let playerId = arg.playerId,
            let cardId = arg.cardId {
            return .playerDiscardHand(playerId, cardId)
        }
        
        if let arg = update.playerPutInPlay,
            let playerId = arg.playerId,
            let cardId = arg.cardId {
            return .playerPutInPlay(playerId, cardId)
        }
        
        if let arg = update.playerDiscardInPlay,
            let playerId = arg.playerId,
            let cardId = arg.cardId {
            return .playerDiscardInPlay(playerId, cardId)
        }
        
        if let arg = update.playerPullFromGeneralStore,
            let playerId = arg.playerId,
            let cardId = arg.cardId {
            return .playerPullFromGeneralStore(playerId, cardId)
        }
        
        if let arg = update.playerRevealHandCard,
            let playerId = arg.playerId,
            let cardId = arg.cardId {
            return .playerRevealHandCard(playerId, cardId)
        }
        
        if let arg = update.playerPullFromOtherHand,
            let playerId = arg.playerId,
            let otherId = arg.otherId,
            let cardId = arg.cardId {
            return .playerPullFromOtherHand(playerId, otherId, cardId)
        }
        
        if let arg = update.playerPullFromOtherInPlay,
            let playerId = arg.playerId,
            let otherId = arg.otherId,
            let cardId = arg.cardId {
            return .playerPullFromOtherInPlay(playerId, otherId, cardId)
        }
        
        if let arg = update.playerPutInPlayOfOther,
            let playerId = arg.playerId,
            let otherId = arg.otherId,
            let cardId = arg.cardId {
            return .playerPutInPlayOfOther(playerId, otherId, cardId)
        }
        
        if let arg = update.playerPassInPlayOfOther,
            let playerId = arg.playerId,
            let otherId = arg.otherId,
            let cardId = arg.cardId {
            return .playerPassInPlayOfOther(playerId, otherId, cardId)
        }
        
        throw NSError(domain: "invalid GameUpdateDto", code: 0)
    }
    
    func decode(damageEvent: DamageEventDto?) throws -> DamageEvent? {
        guard let damageEvent = damageEvent else {
            return nil
        }
        
        return DamageEvent(damage: try damageEvent.damage.unwrap(),
                           source: try decode(damageSource: try damageEvent.source.unwrap()))
    }
    
    func decode(challenge: ChallengeDto?) throws -> Challenge? {
        guard let challenge = challenge else {
            return nil
        }
        
        return try Challenge(name: MoveName(challenge.name.unwrap()),
                             targetIds: challenge.targetIds ?? [],
                             damage: try challenge.damage.unwrap(),
                             counterNeeded: try challenge.counterNeeded.unwrap(),
                             barrelsPlayed: try challenge.barrelsPlayed.unwrap())
    }
}

private extension DtoDecoder {
    
    func decode(orderedCards: [String: String]?) throws -> [CardProtocol] {
        guard let orderedCards = orderedCards else {
            return []
        }
        
        let orderedKeys = orderedCards.keys.sorted()
        return try orderedKeys.map { try decode(card: orderedCards[$0].unwrap()) }
    }
    
    func decode(cards: [String: Bool]?) throws -> [CardProtocol] {
        guard let cards = cards else {
            return []
        }
        
        var result: [CardProtocol] = []
        try cards.forEach { key, _ in
            let card = try decode(card: key)
            result.append(card)
        }
        
        return result.sorted(by: { $0.identifier < $1.identifier })
    }
    
    func decode(outcome: String?) throws -> GameOutcome? {
        guard let outcome = outcome else {
            return nil
        }
        
        return try GameOutcome(rawValue: outcome).unwrap()
    }
    
    func decode(players: [String: PlayerDto]?) throws -> [PlayerProtocol] {
        let playerDtos = Array(try players.unwrap().values)
        
        return try playerDtos
            .sorted(by: { ($0.index ?? 0) < ($1.index ?? 0) })
            .map { try self.decode(player: $0) }
        
    }
    
    func decode(player: PlayerDto) throws -> PlayerProtocol {
        Player(identifier: try player.identifier.unwrap(),
               role: try Role(rawValue: try player.role.unwrap()).unwrap(),
               figureName: try FigureName(rawValue: try player.figureName.unwrap()).unwrap(),
               imageName: try player.imageName.unwrap(),
               description: try player.description.unwrap(),
               abilities: try decode(abilities: player.abilities),
               maxHealth: try player.maxHealth.unwrap(),
               health: try player.health.unwrap(),
               hand: try decode(cards: player.hand),
               inPlay: try decode(cards: player.inPlay),
               bangsPlayed: try player.bangsPlayed.unwrap(),
               lastDamage: try decode(damageEvent: player.lastDamage))
    }
    
    func decode(abilities: [String: Bool]?) throws -> [AbilityName: Bool] {
        guard let abilities = abilities else {
            return [:]
        }
        
        var result: [AbilityName: Bool] = [:]
        try abilities.forEach { key, value in
            let ability = try AbilityName(rawValue: key).unwrap()
            result[ability] = value
        }
        return result
    }
    
    func decode(damageSource: DamageSourceDto) throws -> DamageSource {
        if damageSource.byDynamite == true {
            return .byDynamite
        }
        
        if let playerId = damageSource.byPlayer {
            return .byPlayer(playerId)
        }
        
        throw NSError(domain: "invalid DamageSourceDto", code: 0)
    }
    
    func decode(targetCard: TargetCardDto?) throws -> TargetCard? {
        guard let targetCard = targetCard else {
            return nil
        }
        
        return TargetCard(ownerId: try targetCard.ownerId.unwrap(),
                          source: try decode(targetCardSource: try targetCard.source.unwrap()))
    }
    
    func decode(targetCardSource: TargetCardSourceDto) throws -> TargetCardSource {
        if targetCardSource.randomHand == true {
            return .randomHand
        }
        
        if let cardId = targetCardSource.inPlay {
            return .inPlay(cardId)
        }
        
        throw NSError(domain: "invalid TargetCardSourceDto", code: 0)
    }
    
}
