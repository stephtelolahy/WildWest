//
//  FirebaseMapper.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 26/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Firebase

protocol FirebaseMapperProtocol {
    
    func decodeState(from snapshot: DataSnapshot) throws -> GameStateProtocol
    func decodeCard(from snapthot: DataSnapshot) throws -> (String, CardProtocol)
    func decodeCard(from cardId: String) throws -> CardProtocol
    func decodeCards(from snapshot: DataSnapshot) throws -> [CardProtocol]
    func decodeMove(from snapshot: DataSnapshot) throws -> GameMove?
    func decodeMoves(from snapshot: DataSnapshot) throws -> [GameMove]
    
    func encodeState(_ state: GameStateProtocol) throws -> [String: Any]
    func encodeChallenge(_ challenge: Challenge?) throws -> [String: Any]?
    func encodeDamageEvent(_ damageEvent: DamageEvent) throws -> [String: Any]
    func encodeOrderedCards(_ cards: [CardProtocol]) throws -> [String: Any]
    func encodeMove(_ move: GameMove) throws -> [String: Any]
    func encodeMoves(_ moves: [GameMove]) throws -> [[String: Any]]
}

class FirebaseMapper: FirebaseMapperProtocol {
    
    private let dtoEncoder: DtoEncoder
    private let dtoDecoder: DtoDecoder
    private let dictionaryEncoder: DictionaryEncoder
    private let dictionaryDecoder: DictionaryDecoder
    
    init(dtoEncoder: DtoEncoder,
         dtoDecoder: DtoDecoder,
         dictionaryEncoder: DictionaryEncoder,
         dictionaryDecoder: DictionaryDecoder) {
        self.dtoEncoder = dtoEncoder
        self.dtoDecoder = dtoDecoder
        self.dictionaryEncoder = dictionaryEncoder
        self.dictionaryDecoder = dictionaryDecoder
        
    }
    
    func decodeState(from snapshot: DataSnapshot) throws -> GameStateProtocol {
        let value = try (snapshot.value as? [String: Any]).unwrap()
        let dto = try self.dictionaryDecoder.decode(StateDto.self, from: value)
        let state = try self.dtoDecoder.decode(state: dto)
        return state
    }
    
    func decodeCard(from snapthot: DataSnapshot) throws -> (String, CardProtocol) {
        let dictionary = try (snapthot.value as? [String: String]).unwrap()
        let key = try dictionary.keys.first.unwrap()
        let cardId = try dictionary.values.first.unwrap()
        let card = try dtoDecoder.decode(card: cardId)
        return (key, card)
    }
    
    func decodeCard(from cardId: String) throws -> CardProtocol {
        try dtoDecoder.decode(card: cardId)
    }
    
    func decodeCards(from snapshot: DataSnapshot) throws -> [CardProtocol] {
        let dictionary = try (snapshot.value as? [String: String]).unwrap()
        let keys = dictionary.keys.sorted()
        return try keys.map { key in
            let cardId = try dictionary[key].unwrap()
            let card = try dtoDecoder.decode(card: cardId)
            return card
        }
    }
    
    func decodeMove(from snapshot: DataSnapshot) throws -> GameMove? {
        guard let value = snapshot.value as? [String: Any] else {
            return nil
        }
        
        let dto = try self.dictionaryDecoder.decode(MoveDto.self, from: value)
        let move = try self.dtoDecoder.decode(move: dto)
        return move
    }
    
    func decodeMoves(from snapshot: DataSnapshot) throws -> [GameMove] {
        guard let values = snapshot.value as? [[String: Any]] else {
            return []
        }
        
        return try values.map { value in
            let dto = try self.dictionaryDecoder.decode(MoveDto.self, from: value)
            let move = try self.dtoDecoder.decode(move: dto)
            return move
        }
    }
    
    func encodeState(_ state: GameStateProtocol) throws -> [String: Any] {
        let dto = dtoEncoder.encode(state: state)
        let value = try dictionaryEncoder.encode(dto)
        return value
    }
    
    func encodeChallenge(_ challenge: Challenge?) throws -> [String: Any]? {
        guard let dto = dtoEncoder.encode(challenge: challenge) else {
            return nil
        }
        
        let value = try dictionaryEncoder.encode(dto)
        return value
    }
    
    func encodeDamageEvent(_ damageEvent: DamageEvent) throws -> [String: Any] {
        let dto = try dtoEncoder.encode(damageEvent: damageEvent).unwrap()
        let value = try dictionaryEncoder.encode(dto)
        return value
    }
    
    func encodeOrderedCards(_ cards: [CardProtocol]) throws -> [String: Any] {
        let dto = dtoEncoder.encode(orderedCards: cards)
        let value = try dictionaryEncoder.encode(dto)
        return value
    }
    
    func encodeMove(_ move: GameMove) throws -> [String: Any] {
        let dto = dtoEncoder.encode(move: move)
        let value = try dictionaryEncoder.encode(dto)
        return value
    }
    
    func encodeMoves(_ moves: [GameMove]) throws -> [[String: Any]] {
        try moves.map { try encodeMove($0) }
    }
}
