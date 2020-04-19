//
//  StartTurn.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 3/16/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class StartTurnMatcher: MoveMatcherProtocol {
    
    func autoPlayMove(matching state: GameStateProtocol) -> GameMove? {
        guard let challenge = state.challenge,
            case .startTurn = challenge.name,
            let actor = state.player(state.turn),
            !actor.inPlay.contains(where: { $0.name == .jail }),
            !actor.inPlay.contains(where: { $0.name == .dynamite }) else {
                return nil
        }
        
        return GameMove(name: .startTurn, actorId: actor.identifier)
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .startTurn = move.name,
            let actor = state.player(move.actorId) else {
                return nil
        }
        
        if actor.abilities[.drawsAnotherCardIfSecondDrawIsRedSuit] == true {
            return executeDrawsAnotherCardIfSecondDrawIsRedSuit(actorId: actor.identifier, in: state)
        }
        
        return executeDefaultStartTurn(actorId: actor.identifier)
    }
    
    private func executeDefaultStartTurn(actorId: String) -> [GameUpdate]? {
        [.playerPullFromDeck(actorId),
         .playerPullFromDeck(actorId),
         .setChallenge(nil)]
    }
    
    private func executeDrawsAnotherCardIfSecondDrawIsRedSuit(actorId: String,
                                                              in state: GameStateProtocol) -> [GameUpdate]? {
        let secondCard = state.deck[1]
        
        var updates: [GameUpdate] = [.playerPullFromDeck(actorId),
                                     .playerPullFromDeck(actorId),
                                     .playerRevealHandCard(actorId, secondCard.identifier)]
        
        if secondCard.suit.isRed {
            updates.append(.playerPullFromDeck(actorId))
        }
        
        updates.append(.setChallenge(nil))
        
        return updates
    }
}

extension MoveName {
    static let startTurn = MoveName("startTurn")
}
