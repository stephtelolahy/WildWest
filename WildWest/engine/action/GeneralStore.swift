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
    
    func execute(in state: GameStateProtocol) {
        guard let actorIndex = state.players.firstIndex(where: { $0.identifier == actorId }) else {
            return
        }
        
        state.discardHand(playerId: actorId, cardId: cardId)
        let playersCount = state.players.count
        let playerIds = Array(0..<playersCount).map { state.players[(actorIndex + $0) % playersCount].identifier }
        state.setChallenge(.generalStore(playerIds))
        state.setupGeneralStore(count: playersCount)
    }
    
    var description: String {
        "\(actorId) plays \(cardId)"
    }
}

struct GeneralStoreRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [GenericAction]? {
        guard state.challenge == nil,
            let actor = state.players.first(where: { $0.identifier == state.turn }) else {
            return nil
        }
        
        let cards = actor.handCards(named: .generalStore)
        guard !cards.isEmpty else {
            return nil
        }
        
        return cards.map { GenericAction(name: $0.name.rawValue,
                                         actorId: actor.identifier,
                                         cardId: $0.identifier,
                                         options: [GeneralStore(actorId: actor.identifier, cardId: $0.identifier)])
        }
    }
}
