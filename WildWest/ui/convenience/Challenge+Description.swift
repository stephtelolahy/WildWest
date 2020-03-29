//
//  Challenge+Description.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension Challenge {
    
    var description: String {
        switch name {
        case .dynamiteExploded:
            return "dynamite exploded"
            
        case .duel:
            return "duel by \(actorId ?? "")"
            
        case .bang:
            return "bang by \(actorId ?? "")"
            
        case .gatling:
            return "gatling by \(actorId ?? "")"
            
        case .indians:
            return "indians by \(actorId ?? "")"
            
        case .generalStore:
            return "general store by \(actorId ?? "")"
            
        case .discardExcessCards:
            return "discard excess cards"
            
        default:
            fatalError("Illegal state")
        }
    }
}
