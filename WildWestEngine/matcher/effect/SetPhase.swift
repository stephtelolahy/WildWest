//
//  SetPhase.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Set phase X
 */
public class SetPhase: GEffect {
    
    @Argument(name: "value")
    var value: Int
    
    override func apply(_ ctx: EffectContext) -> [GEvent]? {
        [.setPhase(value: value)]
    }
}
