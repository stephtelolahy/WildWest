//
//  Missed.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct Missed: ActionProtocol {
    let actorId: String
    let cardId: String
    
    func execute(state: GameStateProtocol) {
    }
}

extension Missed: RuleProtocol {
    
    static func match(state: GameStateProtocol) -> [Missed] {
        return []
    }
}
