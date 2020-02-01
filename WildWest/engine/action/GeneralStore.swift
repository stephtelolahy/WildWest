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
    
    func execute(in state: GameStateProtocol) {
    }
    
    var description: String {
        "\(actorId) play \(cardId)"
    }
}
