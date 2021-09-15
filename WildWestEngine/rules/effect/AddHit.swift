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
    
    override func apply(_ ctx: PlayContext) -> [GEvent]? {
        let players = ctx.players(matching: player)
        let times = ctx.get(times)
        let cancelable = ctx.get(cancelable)
        
        var playerArray: [String] = []
        var targetArray: [String] = []
        
        for _ in (0..<times) {
            for player in players {
                if target == .nobody {
                    playerArray.append(player)
                } else {
                    let targets = ctx.players(matching: target)
                    guard !targets.isEmpty else {
                        return nil
                    }
                    
                    targets.forEach { target in
                        targetArray.append(target)
                        playerArray.append(player)
                    }
                }
            }
        }
        
        let hit = GHit(name: ctx.ability,
                       players: playerArray,
                       abilities: abilities,
                       cancelable: cancelable,
                       targets: targetArray)
        return [.addHit(hit: hit)]
    }
}
