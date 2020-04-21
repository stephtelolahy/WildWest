//
//  Challenge+Description.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension Challenge {
    
    func description(in state: GameStateProtocol) -> String {
        switch name {
        case .dynamiteExploded:
            return "dynamite exploded (-\(damage))"
            
        case .duel:
            return "duel by \(state.turn)"
            
        case .bang:
            return "bang by \(state.turn)"
            
        case .gatling:
            return "gatling by \(state.turn)"
            
        case .indians:
            return "indians by \(state.turn)"
            
        case .generalStore:
            return "general store by \(state.turn)"
            
        default:
            fatalError("Illegal state")
        }
    }
}
