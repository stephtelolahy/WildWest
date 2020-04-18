//
//  ResolveJail.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 05/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class ResolveJailMatcher: MoveMatcherProtocol {
    
    func autoPlayMove(matching state: GameStateProtocol) -> GameMove? {
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
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard move.name == .escapeFromJail || move.name == .stayInJail,
            let cardId = move.cardId,
            let actor = state.player(move.actorId) else {
                return nil
        }
        
        var updates: [GameUpdate] = Array(1...actor.flippedCardsCount).map { _ in .flipOverFirstDeckCard }
        updates.append(.playerDiscardInPlay(move.actorId, cardId))
        if move.name == .stayInJail {
            updates.append(.setTurn(state.nextPlayer(after: move.actorId)))
        }
        
        return updates
    }
}

extension MoveName {
    static let escapeFromJail = MoveName("escapeFromJail")
    static let stayInJail = MoveName("stayInJail")
}
