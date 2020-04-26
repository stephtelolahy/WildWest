//
//  FirebaseMapper.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 26/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Firebase

protocol FirebaseMapperProtocol {
    
    func decodeState(from snapshot: DataSnapshot) -> GameStateProtocol
    func decodeCard(from snapthot: DataSnapshot) throws -> (String, CardProtocol)
    
    func encodeState(_ state: GameStateProtocol) -> [String: Any]
    func encodeChallenge(_ challenge: Challenge?) -> [String: Any]?
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
    
    func decodeState(from snapshot: DataSnapshot) -> GameStateProtocol {
        guard let value = snapshot.value as? [String: Any] else {
            fatalError("Unable to create dictionary")
        }
        
        guard let dto = try? self.dictionaryDecoder.decode(StateDto.self, from: value) else {
            fatalError("Unable to create dto")
        }
        
        guard let state = try? self.dtoDecoder.decode(dto: dto) else {
            fatalError("Unable to create state")
        }
        
        return state
    }
    
    func decodeCard(from snapthot: DataSnapshot) throws -> (String, CardProtocol) {
        let dictionary = try (snapthot.value as? [String: String]).unwrap()
        let key = try dictionary.keys.first.unwrap()
        let cardId = try dictionary.values.first.unwrap()
        let card = try dtoDecoder.decode(card: cardId)
        return (key, card)
    }
    
    func encodeState(_ state: GameStateProtocol) -> [String: Any] {
        let dto = dtoEncoder.encode(state: state)
        guard let value = try? dictionaryEncoder.encode(dto) else {
            fatalError("Unable to create value")
        }
        
        return value
    }
    
    func encodeChallenge(_ challenge: Challenge?) -> [String: Any]? {
        guard let dto = dtoEncoder.encode(challenge: challenge) else {
            return nil
        }
        
        guard let value = try? dictionaryEncoder.encode(dto) else {
            fatalError("Unable to encode challenge")
        }
        
        return value
    }
}
