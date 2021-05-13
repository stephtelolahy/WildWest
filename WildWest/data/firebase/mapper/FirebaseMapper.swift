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
    
    // MARK: - State
    func decodeState(from snapshot: DataSnapshot) throws -> StateProtocol
    func encodeState(_ state: StateProtocol) throws -> [String: Any]
    
    // MARK: - Event
    func decodeEvent(from snapshot: DataSnapshot) throws -> GEvent
    func encodeEvent(_ event: GEvent) throws -> [String: Any]
    
    // MARK: - User
    func encodeUser(_ user: UserInfo) throws -> [String: Any]
    func decodeUser(from snapshot: DataSnapshot) throws -> UserInfo
    func decodeUsers(from snapshot: DataSnapshot) throws -> [UserInfo]
    func encodeUserStatus(_ status: UserStatus) throws -> [String: Any]?
    func decodeUserStatus(from snapshot: DataSnapshot) throws -> UserStatus
    func encodeGameUsers(_ users: [String: UserInfo]) throws -> [String: Any]
    func decodeGameUsers(from snapshot: DataSnapshot) throws -> [String: UserInfo]
    func decodeUserStatuses(from snapshot: DataSnapshot) throws -> [String: UserStatus]
}

class FirebaseMapper: FirebaseMapperProtocol {
    
    private let dtoEncoder: DtoEncoder
    private let dictionaryEncoder: DictionaryEncoder
    
    init(dtoEncoder: DtoEncoder,
         dictionaryEncoder: DictionaryEncoder) {
        self.dtoEncoder = dtoEncoder
        self.dictionaryEncoder = dictionaryEncoder
        
    }
    
    // MARK: - State
    
    func decodeState(from snapshot: DataSnapshot) throws -> StateProtocol {
        let value = try (snapshot.value as? [String: Any]).unwrap()
        let dto = try self.dictionaryEncoder.decode(StateDto.self, from: value)
        let state = try self.dtoEncoder.decode(state: dto)
        return state
    }
    
    func encodeState(_ state: StateProtocol) throws -> [String: Any] {
        let dto = dtoEncoder.encode(state: state)
        let value = try dictionaryEncoder.encode(dto)
        return value
    }
    
    // MARK: - Event
    
    func decodeEvent(from snapshot: DataSnapshot) throws -> GEvent {
        let value = try (snapshot.value as? [String: Any]).unwrap()
        let dto = try self.dictionaryEncoder.decode(EventDto.self, from: value)
        let update = try self.dtoEncoder.decode(event: dto)
        return update
    }
    
    func encodeEvent(_ event: GEvent) throws -> [String: Any] {
        let dto = dtoEncoder.encode(event: event)
        let value = try dictionaryEncoder.encode(dto)
        return value
    }
    
    // MARK: - User
    
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
    
    func decodeUserStatuses(from snapshot: DataSnapshot) throws -> [String: UserStatus] {
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
