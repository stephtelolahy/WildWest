//
//  BeerLastLifePoint.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 1/22/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct BeerLastLifePoint: ActionProtocol {
    let actorId: String
    let cardId: String
    
    func execute(state: GameStateProtocol) {
    }
    
    var message: String {
        "\(actorId) play \(cardId)"
    }
}

extension BeerLastLifePoint: RuleProtocol {
    
    static func match(state: GameStateProtocol) -> [BeerLastLifePoint] {
        return []
    }
}
