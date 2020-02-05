//
//  ActionsAdapter.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 04/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct ActionItem {
    let action: GenericAction?
    let card: CardProtocol?
}

protocol ActionsAdapterProtocol {
    var items: [ActionItem] { get }
    
    func setState(_ state: GameStateProtocol)
    func setPlayerIdentifier(_ identifier: String?)
}

class ActionsAdapter: ActionsAdapterProtocol {
    
    var items: [ActionItem] = []
    private var playerIdentifier: String?
    private var state: GameStateProtocol?
    
    func setState(_ state: GameStateProtocol) {
        self.state = state
        updateItems()
    }
    
    func setPlayerIdentifier(_ identifier: String?) {
        self.playerIdentifier = identifier
        updateItems()
    }
    
    private func updateItems() {
        items = buildItems()
    }
    
    private func buildItems() -> [ActionItem] {
        guard let playerIdentifier = self.playerIdentifier,
            let state = self.state,
            let player = state.players.first(where: { $0.identifier == playerIdentifier }) else {
                return []
        }
        
        let cards = player.hand
        let actions = state.actions.filter { $0.actorId == playerIdentifier }
        var result: [ActionItem] = []
        let cardLessActions = actions.filter { $0.cardId == nil }
        cardLessActions.forEach { result.append(ActionItem(action: $0, card: nil)) }
        
        cards.forEach { card in
            let action = actions.first(where: { $0.cardId == card.identifier })
            result.append(ActionItem(action: action, card: card))
        }
        
        return result
    }
}
