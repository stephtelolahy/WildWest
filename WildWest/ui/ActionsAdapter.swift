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
    func setPlayerIdentifier(_ identifier: String?)
}

class ActionsAdapter: ActionsAdapterProtocol {
    
    var items: [ActionItem] = []
    private var playerIdentifier: String?
    private var state: GameStateProtocol?
    
    func setState(_ state: GameStateProtocol) {
        self.state = state
        items = buildItems()
    }
    
    func setPlayerIdentifier(_ identifier: String?) {
        self.playerIdentifier = identifier
        items = buildItems()
    }
    
    private func buildItems() -> [ActionItem] {
        guard let playerIdentifier = self.playerIdentifier,
            let state = self.state,
            let player = state.players.first(where: { $0.identifier == playerIdentifier }) else {
                return []
        }
        
        var result: [ActionItem] = []
        
        let actions = state.actions.filter { $0.actorId == playerIdentifier }
        
        let cardLessActions = actions.filter { $0.cardId.isEmpty }
        if !cardLessActions.isEmpty {
            result.append(ActionItem(card: nil, actions: cardLessActions))
        }
        
        player.hand.forEach { card in
            let cardActions = actions.filter { $0.cardId == card.identifier }
            result.append(ActionItem(card: card, actions: cardActions))
        }
        
        return result
    }
}
