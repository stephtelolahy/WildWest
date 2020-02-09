//
//  RuleProtocol.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/17/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

protocol RuleProtocol {
    func match(with state: GameStateProtocol) -> [GenericAction]?
}

struct GenericAction {
    let name: String
    let actorId: String
    let cardId: String?
    let options: [ActionProtocol]
}
