//
//  RuleProtocol.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/17/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

protocol RuleProtocol {
    func match(with state: GameStateProtocol) -> [ActionProtocol]?
}

protocol ActionProtocol {
    var actorId: String { get }
    var cardId: String { get }
    var description: String { get }
    var autoPlay: Bool { get }
    
    func execute(in state: GameStateProtocol) -> [GameUpdateProtocol]
}
