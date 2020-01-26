//
//  EndTurn.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/31/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct EndTurn: ActionProtocol {
    let actorId: String
    let cardIds: [String]
    
    func execute(state: GameStateProtocol) {
    }
    
    var message: String {
        "\(actorId) end turn"
    }
}

extension EndTurn: RuleProtocol {
    
    static func match(state: GameStateProtocol) -> [EndTurn] {
        return []
    }
}
