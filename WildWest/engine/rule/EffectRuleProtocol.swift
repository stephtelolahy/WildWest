//
//  EffectRuleProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 01/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

protocol EffectRuleProtocol {
    func effectOnExecuting(action: ActionProtocol, in state: GameStateProtocol) -> ActionProtocol?
}
