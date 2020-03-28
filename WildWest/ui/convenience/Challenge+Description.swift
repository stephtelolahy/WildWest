//
//  Challenge+Description.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension Challenge {
    
    var description: String {
        switch self {
        case .dynamiteExploded:
            return "dynamite exploded"
            
        case let .duel(_, offenderId):
            return "duel by \(offenderId)"
            
        case let .shoot(_, cardName, offenderId):
            switch cardName {
            case .bang:
                return "bang by \(offenderId)"
            case .gatling:
                return "gatling by \(offenderId)"
            default:
                return "shoot by \(offenderId)"
            }
            
        case let .indians(_, offenderId):
            return "indians by \(offenderId)"
            
        case .generalStore:
            return "choose card from general store"
            
        default:
            fatalError("Illegal state")
        }
    }
}
