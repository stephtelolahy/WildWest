//
//  Indians.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct Indians: ActionProtocol {
    let actorId: String
    let cardId: String
    
    func execute(state: MutableGameStateProtocol) {
    }
}

extension Indians: RuleProtocol {
    
    static func match(state: GameStateProtocol) -> [ActionProtocol]? {
        return nil
    }
}
