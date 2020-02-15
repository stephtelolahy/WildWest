//
//  GameUpdateProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 09/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

/// Elementary game update which could be materialized by an animation
protocol GameUpdateProtocol {
    var description: String { get }
    
    func execute(in state: MutableGameStateProtocol)
}
