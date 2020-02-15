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
        var actions = state.actions.filter { $0.actorId == playerIdentifier }
        player.hand.forEach { card in
            result.append(ActionItem(card: card, actions: actions.filter { $0.cardId == card.identifier }))
            actions.removeAll(where: { $0.cardId == card.identifier })
        }
        if !actions.isEmpty {
            result.insert(ActionItem(card: nil, actions: actions), at: 0)
        }
        return result
    }
}