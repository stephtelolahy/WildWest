//
//  ResolveJail.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 05/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class ResolveJailMatcher: MoveMatcherProtocol {
    
    func autoPlay(matching state: GameStateProtocol) -> GameMove? {
        guard let challenge = state.challenge,
            case .startTurn = challenge.name,
            let actor = state.player(state.turn),
            !actor.inPlay.contains(where: { $0.name == .dynamite }),
            let card = actor.inPlay.first(where: { $0.name == .jail }) else {
                return nil
        }
        
        let flippedCards = state.deck[0..<actor.flippedCardsCount]
        let moveName: MoveName = flippedCards.contains(where: { $0.makeEscapeFromJail }) ? .escapeFromJail : .stayInJail
        
        return GameMove(name: moveName, actorId: actor.identifier, cardId: card.identifier)
    }
    
    func updates(onExecuting move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard move.name == .escapeFromJail || move.name == .stayInJail,
            let cardId = move.cardId,
            let actor = state.player(move.actorId) else {
                return nil
        }
        
        var updates: [GameUpdate] = []
        
        Array(1...actor.flippedCardsCount).forEach { _ in
            updates.append(.flipOverFirstDeckCard)
        }
        
        if move.name == .stayInJail {
            updates.append(.setTurn(state.nextPlayer(after: move.actorId)))
        }
        
        updates.append(.playerDiscardInPlay(move.actorId, cardId))
        
        return updates
    }
}

extension MoveName {
    static let escapeFromJail = MoveName("escapeFromJail")
    static let stayInJail = MoveName("stayInJail")
}
