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
public class GainHealth: Effect {
    
    @Argument(name: "player", defaultValue: .actor)
    var player: PlayerArgument
    
    @Argument(name: "amount", defaultValue: 1)
    var amount: Int
    
    override func apply(_ ctx: EffectContext) -> [GEvent]? {
        ctx.players(matching: player)
            .compactMap { player -> [GEvent]? in
                // <RULE> cannot have more health than maxHealth
                let playerObject = ctx.state.players[player]!
                let gain = min(amount, playerObject.maxHealth - playerObject.health)
                guard gain > 0 else {
                    return nil
                }
                // </RULE>
                
                return Array(0..<gain).map { _ in .gainHealth(player: player) }
            }
            .flatMap { $0 }
    }
}
