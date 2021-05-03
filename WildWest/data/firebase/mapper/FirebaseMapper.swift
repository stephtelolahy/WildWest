//
//  FirebaseMapper.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 26/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Firebase
import WildWestEngine

protocol FirebaseMapperProtocol {
    /*
    func decodeState(from snapshot: DataSnapshot) throws -> GameStateProtocol
    func decodeCard(from snapthot: DataSnapshot) throws -> (String, CardProtocol)
    func decodeCard(from cardId: String) throws -> CardProtocol
    func decodeCards(from snapshot: DataSnapshot) throws -> [CardProtocol]
    func decodeMove(from snapshot: DataSnapshot) throws -> GameMove
    func decodeMoves(from snapshot: DataSnapshot) throws -> [GameMove]
    func decodeUpdate(from snapshot: DataSnapshot) throws -> GameUpdate
    */
    func encodeState(_ state: StateProtocol) throws -> [String: Any]
    /*
    func encodeChallenge(_ challenge: Challenge?) throws -> [String: Any]?
    func encodeDamageEvent(_ damageEvent: DamageEvent) throws -> [String: Any]
    func encodeOrderedCards(_ cards: [CardProtocol]) throws -> [String: Any]
    func encodeMove(_ move: GameMove) throws -> [String: Any]
    func encodeMoves(_ moves: [GameMove]) throws -> [[String: Any]]
    func encodeUpdate(_ update: GameUpdate) throws -> [String: Any]
    */
    
    func encodeUser(_ user: UserInfo) throws -> [String: Any]
    func decodeUser(from snapshot: DataSnapshot) throws -> UserInfo
    func decodeUsers(from snapshot: DataSnapshot) throws -> [UserInfo]
    func encodeUserStatus(_ status: UserStatus) throws -> [String: Any]?
    func decodeUserStatus(from snapshot: DataSnapshot) throws -> UserStatus
    func encodeGameUsers(_ users: [String: UserInfo]) throws -> [String: Any]
    func decodeGameUsers(from snapshot: DataSnapshot) throws -> [String: UserInfo]
    func decodeStatusDictionary(from snapshot: DataSnapshot) throws -> [String: UserStatus]
}

class FirebaseMapper: FirebaseMapperProtocol {
    
    private let dtoEncoder: DtoEncoder
    private let dictionaryEncoder: DictionaryEncoder
    
    init(dtoEncoder: DtoEncoder,
         dictionaryEncoder: DictionaryEncoder) {
        self.dtoEncoder = dtoEncoder
        self.dictionaryEncoder = dictionaryEncoder
        
    }
    /*
    func decodeState(from snapshot: DataSnapshot) throws -> GameStateProtocol {
        let value = try (snapshot.value as? [String: Any]).unwrap()
        let dto = try self.dictionaryEncoder.decode(GameStateDto.self, from: value)
        let state = try self.dtoEncoder.decode(state: dto)
        return state
    }
    
    func decodeCard(from snapthot: DataSnapshot) throws -> (String, CardProtocol) {
        let dictionary = try (snapthot.value as? [String: String]).unwrap()
        let key = try dictionary.keys.first.unwrap()
        let cardId = try dictionary.values.first.unwrap()
        let card = try dtoEncoder.decode(card: cardId)
        return (key, card)
    }
    
    func decodeCard(from cardId: String) throws -> CardProtocol {
        try dtoEncoder.decode(card: cardId)
    }
    
    func decodeCards(from snapshot: DataSnapshot) throws -> [CardProtocol] {
        let dictionary = try (snapshot.value as? [String: String]).unwrap()
        let keys = dictionary.keys.sorted()
        return try keys.map { key in
            let cardId = try dictionary[key].unwrap()
            let card = try dtoEncoder.decode(card: cardId)
            return card
        }
    }
    
    func decodeMove(from snapshot: DataSnapshot) throws -> GameMove {
        let value = try (snapshot.value as? [String: Any]).unwrap()
        let dto = try self.dictionaryEncoder.decode(GameMoveDto.self, from: value)
        let move = try self.dtoEncoder.decode(move: dto)
        return move
    }
    
    func decodeMoves(from snapshot: DataSnapshot) throws -> [GameMove] {
        guard let values = snapshot.value as? [[String: Any]] else {
            return []
        }
        
        return try values.map { value in
            let dto = try self.dictionaryEncoder.decode(GameMoveDto.self, from: value)
            let move = try self.dtoEncoder.decode(move: dto)
            return move
        }
    }
    
    func decodeUpdate(from snapshot: DataSnapshot) throws -> GameUpdate {
        let value = try (snapshot.value as? [String: Any]).unwrap()
        let dto = try self.dictionaryEncoder.decode(GameUpdateDto.self, from: value)
        let update = try self.dtoEncoder.decode(update: dto)
        return update
    }
    */
    func encodeState(_ state: StateProtocol) throws -> [String: Any] {
        let dto = dtoEncoder.encode(state: state)
        let value = try dictionaryEncoder.encode(dto)
        return value
    }
    /*
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
    
    func encodeUpdate(_ update: GameUpdate) throws -> [String: Any] {
        let dto = dtoEncoder.encode(update: update)
        let value = try dictionaryEncoder.encode(dto)
        return value
    }
    */
    func encodeUser(_ user: UserInfo) throws -> [String: Any] {
        let dto = dtoEncoder.encode(user: user)
        let value = try dictionaryEncoder.encode(dto)
        return value
    }
    
    func encodeUserStatus(_ status: UserStatus) throws -> [String: Any]? {
        guard let dto = dtoEncoder.encode(status: status) else {
            return nil
        }
        
        let value = try dictionaryEncoder.encode(dto)
        return value
    }
    
    func decodeUserStatus(from snapshot: DataSnapshot) throws -> UserStatus {
        guard let value = snapshot.value as? [String: Any] else {
            return .idle
        }
        
        let dto = try self.dictionaryEncoder.decode(UserStatusDto.self, from: value)
        let status = try dtoEncoder.decode(status: dto)
        return status
    }
    
    func decodeUser(from snapshot: DataSnapshot) throws -> UserInfo {
        let value = try (snapshot.value as? [String: Any]).unwrap()
        let dto = try dictionaryEncoder.decode(UserInfoDto.self, from: value)
        let user = try dtoEncoder.decode(user: dto)
        return user
    }
    
    func decodeUsers(from snapshot: DataSnapshot) throws -> [UserInfo] {
        guard let dict = snapshot.value as? [String: [String: Any]] else {
            return []
        }
        
        return try dict.values.map { value in
            let dto = try dictionaryEncoder.decode(UserInfoDto.self, from: value)
            let user = try dtoEncoder.decode(user: dto)
            return user
        }
    }
    
    func encodeGameUsers(_ users: [String: UserInfo]) throws -> [String: Any] {
        let dto = Dictionary(uniqueKeysWithValues: users.map { key, value in (key, dtoEncoder.encode(user: value)) })
        let value = try dictionaryEncoder.encode(dto)
        return value
    }
    
    func decodeGameUsers(from snapshot: DataSnapshot) throws -> [String: UserInfo] {
        let dictionary = try (snapshot.value as? [String: [String: Any]]).unwrap()
        return Dictionary(uniqueKeysWithValues: try dictionary.map { key, value in
            let dto = try dictionaryEncoder.decode(UserInfoDto.self, from: value)
            let user = try dtoEncoder.decode(user: dto)
            return (key, user)
        })
    }
    
    func decodeStatusDictionary(from snapshot: DataSnapshot) throws -> [String: UserStatus] {
        guard let dictionary = snapshot.value as? [String: [String: Any]] else {
            return [:]
        }
        
        return Dictionary(uniqueKeysWithValues: try dictionary.map { key, value in
            let dto = try self.dictionaryEncoder.decode(UserStatusDto.self, from: value)
            let status = try dtoEncoder.decode(status: dto)
            return (key, status)
        })
    }
}
