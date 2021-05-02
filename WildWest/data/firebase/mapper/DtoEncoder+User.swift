//
//  DtoEncoder+User.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension DtoEncoder {
    
    func encode(user: UserInfo) -> UserInfoDto {
        UserInfoDto(id: user.id,
                    name: user.name,
                    photoUrl: user.photoUrl)
    }
    
    func decode(user: UserInfoDto) throws -> UserInfo {
        UserInfo(id: try user.id.unwrap(),
                 name: try user.name.unwrap(),
                 photoUrl: try user.photoUrl.unwrap())
    }
    
    func decode(users: [String: UserInfoDto]) throws -> [UserInfo] {
        try Array(users.values)
            .map { try decode(user: $0) }
    }
    
    func encode(status: UserStatus) -> UserStatusDto? {
        switch status {
        case let .playing(gameId, playerId):
            return UserStatusDto(gameId: gameId, playerId: playerId)
            
        case .waiting:
            return UserStatusDto(waiting: true)
            
        default:
            return nil
        }
    }
    
    func decode(status: UserStatusDto?) throws -> UserStatus {
        if status?.waiting == true {
            return .waiting
        }
        
        if let gameId = status?.gameId,
            let playerId = status?.playerId {
            return .playing(gameId: gameId, playerId: playerId)
        }
        
        return .idle
    }
}
