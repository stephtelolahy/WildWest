//
//  GeneralStore.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/31/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct GeneralStore: ActionProtocol {
    let actorId: String
    let cardId: String
    
    func execute(state: GameStateProtocol) {
    }
}

extension GeneralStore: RuleProtocol {
    
    static func match(state: GameStateProtocol) -> [GeneralStore]? {
        return nil
    }
}
