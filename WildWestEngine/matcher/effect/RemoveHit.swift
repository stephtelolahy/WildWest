//
//  RemoveHit.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Remove player from hit
 */
public class RemoveHit: GEffect {
    
    @Argument(name: "player", defaultValue: .actor)
    var player: PlayerArgument
    
    override func apply(_ ctx: EffectContext) -> [GEvent]? {
        guard let player = ctx.players(matching: player).first else {
            return nil
        }
        return [.removeHit(player: player)]
    }
}


