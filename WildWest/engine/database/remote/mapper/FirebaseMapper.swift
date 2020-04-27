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
    
    func encodeState(_ state: GameStateProtocol) throws -> [String: Any]
    func encodeChallenge(_ challenge: Challenge?) throws -> [String: Any]?
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
        let state = try self.dtoDecoder.decode(dto: dto)
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
}
