//
//  BeerLastLifePoint.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 1/22/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct BeerLastLifePoint: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String
    
    func execute(state: GameStateProtocol) {
    }
}

extension BeerLastLifePoint: RuleProtocol {
    
    static func match(state: GameStateProtocol) -> [ActionProtocol]? {
        return nil
    }
}
