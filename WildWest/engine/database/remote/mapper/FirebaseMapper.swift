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
    func encodeState(_ state: GameStateProtocol) -> [String: Any]
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
    
    func encodeState(_ state: GameStateProtocol) -> [String: Any] {
        let dto = dtoEncoder.encode(state: state)
        guard let value = try? dictionaryEncoder.encode(dto) else {
            fatalError("Unable to create value")
        }
        
        return value
    }
}
