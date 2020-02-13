//
//  GeneralStore.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/31/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct GeneralStore: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String
    
    func execute(in state: GameStateProtocol) -> [GameUpdateProtocol] {
        guard let actorIndex = state.players.firstIndex(where: { $0.identifier == actorId }) else {
            return []
        }
        
        let playersCount = state.players.count
        let playerIds = Array(0..<playersCount).map { state.players[(actorIndex + $0) % playersCount].identifier }
        let updates: [GameUpdate] = [
            .playerDiscardHand(actorId, cardId),
            .setupGeneralStore(playersCount),
            .setChallenge(.generalStore(playerIds))
        ]
        return updates
    }
    
    var description: String {
        "\(actorId) plays \(cardId)"
    }
}

struct GeneralStoreRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [ActionProtocol]? {
        guard state.challenge == nil,
            let actor = state.players.first(where: { $0.identifier == state.turn }),
            let cards = actor.handCards(named: .generalStore) else {
                return nil
        }
        
        return cards.map { GeneralStore(actorId: actor.identifier, cardId: $0.identifier) }
    }
}
