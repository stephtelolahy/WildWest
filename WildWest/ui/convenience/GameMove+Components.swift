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
         cardId?.extractCardName(),
         targetId,
         targetCard?.description]
            .compactMap { $0 }
    }
}

extension Dictionary where Key == String, Value == String {
    
    func value(matching move: GameMove) -> String {
        let components = move.asComponents()
        for component in components {
            let filtered = self.filter { component.lowercased().starts(with: $0.key.lowercased()) }
            if let match = filtered.first {
                return match.value
            }
        }
        
        fatalError("No values matching \(components.joined(separator: ", "))")
    }
}

private extension String {
    func extractCardName() -> String {
        components(separatedBy: "-").first ?? self
    }
}
