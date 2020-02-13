//
//  ResolveDynamite.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 05/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct ResolveDynamite: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String = ""
    
    func execute(in state: GameStateProtocol) -> [GameUpdateProtocol] {
        []
    }
    
    var description: String {
        ""
    }
}

struct ResolveDynamiteRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [ActionProtocol]? {
        nil
    }
}
