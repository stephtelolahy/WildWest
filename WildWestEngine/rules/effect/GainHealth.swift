//
//  GainHealth.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Gain life point respecting health limit
 - RULE: cannot have more health than maxHealth
 */
public class GainHealth: GEffect {
    
    @Argument(name: "player", defaultValue: .actor)
    var player: PlayerArgument
    
    override func apply(_ ctx: EffectContext) -> [GEvent]? {
        ctx.players(matching: player)
            .compactMap { player in
                // <RULE> cannot have more health than maxHealth
                let playerObject = ctx.state.players[player]!
                guard playerObject.health < playerObject.maxHealth else {
                    return nil
                }
                // </RULE>
                
                return .gainHealth(player: player)
            }
    }
}
