//
//  GameStateExtension.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 26/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension GameStateProtocol {
    
    func player(identifiedBy identifier: String) -> PlayerProtocol? {
        return players.first(where: { $0.identifier == identifier })
    }
}
