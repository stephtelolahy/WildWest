//
//  ActionsAdapter.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 04/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct ActionItem {
    let card: CardProtocol
    let moves: [GameMove]
}

protocol ActionsAdapterProtocol {
    func buildActions(validMoves: [GameMove]) -> [ActionItem]
    func buildActions(state: GameStateProtocol) -> [ActionItem]
}

class ActionsAdapter: ActionsAdapterProtocol {
    
    private let playerId: String?
    private var validMoves: [GameMove] = []
    private var latestState: GameStateProtocol?
    
    init(playerId: String?) {
        self.playerId = playerId
    }
    
    func buildActions(validMoves: [GameMove]) -> [ActionItem] {
        self.validMoves = validMoves
        return buildActions()
    }
    
    func buildActions(state: GameStateProtocol) -> [ActionItem] {
        self.latestState = state
        return buildActions()
    }
    
    private func buildActions() -> [ActionItem] {
        guard let controlledPlayerId = playerId,
            let state = latestState,
            let player = state.player(controlledPlayerId) else {
                return []
        }
        
        return player.hand.map { card in
            let moves = validMoves.filter { $0.cardId == card.identifier }
            return ActionItem(card: card, moves: moves)
        }
    }
}
