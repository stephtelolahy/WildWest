//
//  Shoot.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct Shoot: ActionProtocol {
    let actorId: String
    let cardId: String
    
    func execute(state: MutableGameStateProtocol) {
        // TODO:
    }
}

extension Shoot: RuleProtocol {
    
    static func match(state: GameStateProtocol) -> [ActionProtocol] {
        // TODO:
        return []
    }
}
