//
//  GameMove+Description.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 22/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension GameMove {
    var description: String {
        var components: [String] =
            [actorId,
             name.rawValue,
             targetId,
             targetCard?.description]
                .compactMap { $0 }
        
        if name == .equip, let cardId = cardId {
            components.append(cardId)
        }
        
        return components.joined(separator: " ")
    }
}
