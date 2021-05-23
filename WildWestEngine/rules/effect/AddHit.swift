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
class AddHit: GEffect {
    
    @Argument(name: "player", defaultValue: .actor)
    var player: PlayerArgument
    
    @Argument(name: "abilities")
    var abilities: [String]
    
    @Argument(name: "times", defaultValue: 1)
    var times: Int
    
    @Argument(name: "cancelable", defaultValue: .never)
    var cancelable: TimesValue
    
    override func apply(_ ctx: EffectContext) -> [GEvent]? {
        let players = ctx.players(matching: player)
        let cancelable = ctx.number(matching: cancelable)
        var targets: [String] = []
        for _ in (0..<times) {
            targets.append(contentsOf: players)
        }
        return [.addHit(players: targets, name: ctx.ability, abilities: abilities, cancelable: cancelable, offender: ctx.actor.identifier)]
    }
}
