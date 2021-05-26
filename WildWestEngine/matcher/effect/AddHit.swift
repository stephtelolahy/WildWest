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
    
    @Argument(name: "times", defaultValue: .one)
    var times: NumberArgument
    
    @Argument(name: "cancelable", defaultValue: .zero)
    var cancelable: NumberArgument
    
    @Argument(name: "target", defaultValue: .nobody)
    var target: PlayerArgument
    
    override func apply(_ ctx: EffectContext) -> [GEvent]? {
        let players = ctx.players(matching: player)
        let times = ctx.number(matching: times)
        let cancelable = ctx.number(matching: cancelable)
        let loopPlayers = (0..<times).flatMap { _ in players }
        let targets = ctx.players(matching: target)
        var hits: [GHit] = []
        loopPlayers.forEach { player in
            
            if targets.isEmpty {
                hits.append(GHit(player: player,
                                 name: ctx.ability,
                                 abilities: abilities,
                                 offender: ctx.actor.identifier,
                                 cancelable: cancelable,
                                 target: nil))
            } else {
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
        
        return [.addHit(hits: hits)]
    }
}
