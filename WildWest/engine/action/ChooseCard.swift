//
//  ChooseCard.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 05/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct ChooseCard: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String
    let autoPlay = false
    
    func execute(in state: GameStateProtocol) -> [GameUpdateProtocol] {
        let updates: [GameUpdate] = [
            .playerPullFromGeneralStore(actorId, cardId),
            .setChallenge(state.challenge?.removing(actorId))
        ]
        return updates
    }
    
    var description: String {
        "\(actorId) chooses \(cardId)"
    }
}

struct ChooseCardRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [ActionProtocol]? {
        var actorId: String?
        switch state.challenge {
        case let .generalStore(playerIds):
            actorId = playerIds.first
            
        default:
            break
        }
        
        guard let actor = state.players.first(where: { $0.identifier == actorId }) else {
            return nil
        }
        
        return state.generalStore.map { ChooseCard(actorId: actor.identifier, cardId: $0.identifier) }
    }
}
