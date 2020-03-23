//
//  GameMove+Components.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension GameMove {
    
    func asComponents() -> [String] {
        [actorId,
         name.rawValue,
         cardName?.rawValue,
         targetId,
         targetCard?.description]
            .compactMap { $0 }
    }
}

extension Dictionary where Key == String, Value == String {
    func value(matching components: [String]) -> String {
        for component in components {
            let filtered = self.filter { component.lowercased().contains($0.key.lowercased()) }
            if let match = filtered.first {
                return match.value
            }
        }
        
        return ""
    }
}
