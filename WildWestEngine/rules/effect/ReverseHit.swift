//
//  ReverseHit.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 23/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Permute hit player and target
 */
class ReverseHit: Effect {
    
    @Argument(name: "player", defaultValue: .actor)
    var player: PlayerArgument
    
    override func apply(_ ctx: PlayContext) -> [GEvent]? {
        guard let player = ctx.players(matching: player).first,
              let hit = ctx.state.hit else {
            fatalError("Invalid hit")
        }
        
        let reversedHit = GHit(name: hit.name,
                               players: hit.targets,
                               abilities: hit.abilities,
                               cancelable: hit.cancelable,
                               targets: hit.players)
        return [.removeHit(player: player),
                .addHit(hit: reversedHit)]
    }
}
