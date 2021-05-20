//
//  DtoEncoder+Event.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 06/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//
// swiftlint:disable cyclomatic_complexity
// swiftlint:disable function_body_length

import Foundation
import WildWestEngine

extension DtoEncoder {
    
    func encode(event: GEvent) -> EventDto {
        switch event {
        case .emptyQueue:
            return EventDto(emptyQueue: true)
            
        case .flipDeck:
            return EventDto(flipDeck: true)
            
        case .deckToStore:
            return EventDto(deckToStore: true)
            
        case let .setPhase(phase):
            return EventDto(setPhase: phase)
            
        case let .setTurn(player):
            return EventDto(setTurn: player)
            
        case let .gainHealth(player):
            return EventDto(gainHealth: player)
            
        case let .drawDeck(player):
            return EventDto(drawDeck: player)
            
        case let .drawDiscard(player):
            return EventDto(drawDiscard: player)
            
        case let .storeToDeck(card):
            return EventDto(storeToDeck: card)
            
        case let .removeHit(player):
            return EventDto(removeHit: player)
            
        case let .cancelHit(player):
            return EventDto(cancelHit: player)
            
        case let .gameover(role):
            return EventDto(gameover: role.rawValue)
            
        case let .run(move):
            return EventDto(run: encode(move: move))
            
        case let .activate(moves):
            let movesDto = moves.map { encode(move: $0) }
            return EventDto(activate: movesDto)
            
        case let .addHit(player, name, abilities, cancelable, offender):
            let hit = GHit(player: player, name: name, abilities: abilities, cancelable: cancelable, offender: offender)
            let dto = encode(hit: hit)
            return EventDto(addHit: dto)
            
        case let .play(player, card):
            return EventDto(play: PlayerCardDto(player: player, card: card))
            
        case let .equip(player, card):
            return EventDto(equip: PlayerCardDto(player: player, card: card))
            
        case let .drawStore(player, card):
            return EventDto(drawStore: PlayerCardDto(player: player, card: card))
            
        case let .discardHand(player, card):
            return EventDto(discardHand: PlayerCardDto(player: player, card: card))
            
        case let .drawDeckFlipping(player):
            return EventDto(drawDeckFlipping: player)
            
        case let .discardInPlay(player, card):
            return EventDto(discardInPlay: PlayerCardDto(player: player, card: card))
            
        case let .looseHealth(player, offender):
            return EventDto(looseHealth: PlayerOffenderDto(player: player, offender: offender))
            
        case let .eliminate(player, offender):
            return EventDto(eliminate: PlayerOffenderDto(player: player, offender: offender))
            
        case let .handicap(player, card, other):
            return EventDto(handicap: PlayerOtherCardDto(player: player, other: other, card: card))
            
        case let .drawHand(player, other, card):
            return EventDto(drawHand: PlayerOtherCardDto(player: player, other: other, card: card))
            
        case let .drawInPlay(player, other, card):
            return EventDto(drawInPlay: PlayerOtherCardDto(player: player, other: other, card: card))
            
        case let .passInPlay(player, card, other):
            return EventDto(passInPlay: PlayerOtherCardDto(player: player, other: other, card: card))
        }
    }
    
    func decode(event: EventDto) throws -> GEvent {
        if event.emptyQueue != nil {
            return .emptyQueue
        }
        
        if event.flipDeck != nil {
            return .flipDeck
        }
        
        if event.deckToStore != nil {
            return .deckToStore
        }
        
        if let phase = event.setPhase {
            return .setPhase(value: phase)
        }
        
        if let player = event.setTurn {
            return .setTurn(player: player)
        }
        
        if let player = event.gainHealth {
            return .gainHealth(player: player)
        }
        
        if let player = event.drawDeck {
            return .drawDeck(player: player)
        }
        
        if let player = event.drawDiscard {
            return .drawDiscard(player: player)
        }
        
        if let card = event.storeToDeck {
            return .storeToDeck(card: card)
        }
        
        if let player = event.removeHit {
            return .removeHit(player: player)
        }
        
        if let player = event.cancelHit {
            return .cancelHit(player: player)
        }
        
        if let dto = event.gameover {
            let role = try Role(rawValue: dto).unwrap()
            return .gameover(winner: role)
        }
        
        if let dto = event.run {
            let move = try decode(move: dto)
            return .run(move: move)
        }
        
        if let dto = event.activate {
            let moves = try dto.map { try decode(move: $0) }
            return .activate(moves: moves)
        }
        
        if let dto = event.addHit {
            let hit = try decode(hit: dto)
            return .addHit(player: hit.player,
                           name: hit.name,
                           abilities: hit.abilities,
                           cancelable: hit.cancelable,
                           offender: hit.offender)
        }
        
        if let dto = event.play {
            return .play(player: try dto.player.unwrap(),
                         card: try dto.card.unwrap())
        }
        
        if let dto = event.equip {
            return .equip(player: try dto.player.unwrap(),
                          card: try dto.card.unwrap())
        }
        
        if let dto = event.drawStore {
            return .drawStore(player: try dto.player.unwrap(),
                              card: try dto.card.unwrap())
        }
        
        if let dto = event.discardHand {
            return .discardHand(player: try dto.player.unwrap(),
                                card: try dto.card.unwrap())
        }
        
        if let player = event.drawDeckFlipping {
            return .drawDeckFlipping(player: player)
        }
        
        if let dto = event.discardInPlay {
            return .discardInPlay(player: try dto.player.unwrap(),
                                  card: try dto.card.unwrap())
        }
        
        if let dto = event.looseHealth {
            return .looseHealth(player: try dto.player.unwrap(),
                                offender: try dto.offender.unwrap())
        }
        
        if let dto = event.eliminate {
            return .eliminate(player: try dto.player.unwrap(),
                              offender: try dto.offender.unwrap())
        }
        
        if let dto = event.handicap {
            return .handicap(player: try dto.player.unwrap(),
                             card: try dto.card.unwrap(),
                             other: try dto.other.unwrap())
        }
        
        if let dto = event.drawHand {
            return .drawHand(player: try dto.player.unwrap(),
                             other: try dto.other.unwrap(),
                             card: try dto.card.unwrap())
        }
        
        if let dto = event.drawInPlay {
            return .drawInPlay(player: try dto.player.unwrap(),
                               other: try dto.other.unwrap(),
                               card: try dto.card.unwrap())
        }
        
        if let dto = event.passInPlay {
            return .passInPlay(player: try dto.player.unwrap(),
                               card: try dto.card.unwrap(),
                               other: try dto.other.unwrap())
        }
        
        return .emptyQueue
    }
}

private extension DtoEncoder {
    
    func encode(move: GMove) -> MoveDto {
        MoveDto(ability: move.ability,
                actor: move.actor,
                card: encode(playCard: move.card),
                args: encode(playArgs: move.args))
    }
    
    func decode(move: MoveDto) throws -> GMove {
        GMove(try move.ability.unwrap(),
              actor: try move.actor.unwrap(),
              card: try decode(playCard: move.card),
              args: try decode(playArgs: move.args))
    }
    
    func encode(playCard: PlayCard?) -> PlayCardDto {
        switch playCard {
        case let .hand(card):
            return PlayCardDto(hand: card)
            
        case let .inPlay(card):
            return PlayCardDto(inPlay: card)
            
        default:
            return PlayCardDto()
        }
    }
    
    func decode(playCard: PlayCardDto?) throws -> PlayCard? {
        if let card = playCard?.hand {
            return .hand(card)
        }
        
        if let card = playCard?.inPlay {
            return .inPlay(card)
        }
        
        return nil
    }
    
    func encode(playArgs: [PlayArg: [String]]?) -> [String: [String]] {
        guard let playArgs = playArgs else {
            return [:]
        }
        
        return Dictionary(uniqueKeysWithValues: playArgs.map({ key, value in
            (key.rawValue, value)
        }))
    }
    
    func decode(playArgs: [String: [String]]?) throws -> [PlayArg: [String]] {
        guard let playArgs = playArgs else {
            return [:]
        }
        
        return Dictionary(uniqueKeysWithValues: try playArgs.map({ key, value in
            (try PlayArg(rawValue: key).unwrap(), value)
        }))
    }
}
