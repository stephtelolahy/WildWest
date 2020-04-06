//
//  Role+Relationship.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 06/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

enum Relationship: String {
    case enemy
    case teammate
    case unknown
}

extension Role {
    
    func relationShip(to role: Role?, playersCount: Int = 0) -> Relationship {
        guard let otherRole = role else {
            return .unknown
        }
        
        switch self {
        case .sheriff:
            return sheriffRelationShip(to: otherRole)
        case .outlaw:
            return outlawRelationShip(to: otherRole)
        case .deputy:
            return deputyRelationShip(to: otherRole)
        case .renegade:
            return renegadeRelationShip(to: otherRole, playersCount: playersCount)
        }
    }
    
    static func estimatedRole(for playerId: String, scores: [String: Int]) -> Role? {
        guard let score = scores[playerId] else {
            return nil
        }
        
        // if attacked sheriff at least once,
        // then estimated role is outlaw
        if score > 0 {
            return .outlaw
        }
        
        return nil
    }
}

private extension Role {
    
    func sheriffRelationShip(to role: Role) -> Relationship {
        switch role {
        case .outlaw:
            return .enemy
        default:
            return .unknown
        }
    }
    
    func outlawRelationShip(to role: Role) -> Relationship {
        switch role {
        case .sheriff:
            return .enemy
        case .outlaw:
            return .teammate
        default:
            return .unknown
        }
    }
    
    func deputyRelationShip(to role: Role) -> Relationship {
        switch role {
        case .sheriff:
            return .teammate
        case .outlaw:
            return .enemy
        default:
            return .unknown
        }
    }
    
    func renegadeRelationShip(to role: Role, playersCount: Int) -> Relationship {
        switch role {
        case .sheriff:
            return playersCount > 2 ? .teammate : .enemy
        default:
            return .unknown
        }
    }
}
