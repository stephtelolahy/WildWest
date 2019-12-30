//
//  Gatling.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct Gatling: ActionProtocol {
    let actorId: String
    let cardId: String
    
    func execute(state: GameStateProtocol) {
        // TODO:
    }
}

extension Gatling: RuleProtocol {
    
    static func match(state: GameStateProtocol) -> [ActionProtocol] {
        // TODO:
        return []
    }
}
