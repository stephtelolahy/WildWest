//
//  ActionsAdapter.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 04/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct ActionItem {
    let card: CardProtocol?
    let actions: [ActionProtocol]
}

protocol ActionsAdapterProtocol {
    var items: [ActionItem] { get }
    
    func setState(_ state: GameStateProtocol)
    func setControlledPlayerId(_ identifier: String?)
}

class ActionsAdapter: ActionsAdapterProtocol {
    
    var items: [ActionItem] = []
    private var controlledPlayerId: String?
    private var state: GameStateProtocol?
    
    func setState(_ state: GameStateProtocol) {
        self.state = state
        items = buildItems()
    }
    
    func setControlledPlayerId(_ identifier: String?) {
        self.controlledPlayerId = identifier
        items = buildItems()
    }
    
    private func buildItems() -> [ActionItem] {
        guard let state = self.state,
            let playerIdentifier = self.controlledPlayerId,
            let player = state.players.first(where: { $0.identifier == playerIdentifier }) else {
                return []
        }
        
        var result: [ActionItem] = []
        var actions = state.validMoves.filter { $0.actorId == playerIdentifier }
        player.hand.forEach { card in
            let cardActions = actions.filter { ($0 as? PlayCardAtionProtocol)?.cardId == card.identifier }
            result.append(ActionItem(card: card, actions: cardActions))
            actions.removeAll(where: { ($0 as? PlayCardAtionProtocol)?.cardId == card.identifier })
        }
        if !actions.isEmpty {
            result.insert(ActionItem(card: nil, actions: actions), at: 0)
        }
        return result
    }
}
