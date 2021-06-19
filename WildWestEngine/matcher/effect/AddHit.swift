//
//  AddHit.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Add hit
 */
class AddHit: Effect {
    
    @Argument(name: "player", defaultValue: .actor)
    var player: PlayerArgument
    
    @Argument(name: "abilities")
    var abilities: [String]
    
    @Argument(name: "times", defaultValue: .number(1))
    var times: NumberArgument
    
    @Argument(name: "cancelable", defaultValue: .number(0))
    var cancelable: NumberArgument
    
    @Argument(name: "target", defaultValue: .nobody)
    var target: PlayerArgument
    
    override func apply(_ ctx: MoveContext) -> [GEvent]? {
        let players = ctx.players(matching: player)
        let times = ctx.number(matching: times)
        let cancelable = ctx.number(matching: cancelable)
        var hits: [GHit] = []
        
        for _ in (0..<times) {
            for player in players {
                if target == .nobody {
                    hits.append(GHit(player: player,
                                     name: ctx.ability,
                                     abilities: abilities,
                                     offender: ctx.actor.identifier,
                                     cancelable: cancelable,
                                     target: nil))
                } else {
                    let targets = ctx.players(matching: target)
                    guard !targets.isEmpty else {
                        return nil
                    }
                    
                    targets.forEach { target in
                        hits.append(GHit(player: player,
                                         name: ctx.ability,
                                         abilities: abilities,
                                         offender: ctx.actor.identifier,
                                         cancelable: cancelable,
                                         target: target))
                    }
                }
            }
        }
        
        return [.addHit(hits: hits)]
    }
}
