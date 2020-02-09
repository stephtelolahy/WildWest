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
    
    func execute(in state: GameStateProtocol) {
        state.setChallenge(state.challenge?.removing(actorId))
        state.pullGeneralStore(playerId: actorId, cardId: cardId)
    }
    
    var description: String {
        return "\(actorId) chooses \(cardId)"
    }
}

struct ChooseCardRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [GenericAction]? {
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
        
        let options = state.generalStoreCards.map { ChooseCard(actorId: actor.identifier, cardId: $0.identifier) }
        return [GenericAction(name: "chooseCard",
                              actorId: actor.identifier,
                              cardId: nil,
                              options: options)]
    }
}
