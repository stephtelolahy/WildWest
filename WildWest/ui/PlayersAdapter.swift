//
//  PlayersAdapter.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 04/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct PlayerItem {
    let player: PlayerProtocol?
    let isActive: Bool
}

protocol PlayersAdapterProtocol {
    var items: [PlayerItem] { get }
    
    func setState(_ state: GameStateProtocol)
}

class PlayersAdapter: PlayersAdapterProtocol {
    
    var items: [PlayerItem] = []
    
    private var state: GameStateProtocol?
    
    func setState(_ state: GameStateProtocol) {
        self.state = state
        updateItems()
    }
    
    private func updateItems() {
        items = buildItems()
    }
    
    private func buildItems() -> [PlayerItem] {
        guard let state = self.state else {
            return []
        }
        
        let indexes = playerIndexes[state.players.count]
        return indexes.map { index in
            if index == 0 {
                return PlayerItem(player: nil, isActive: false)
            } else {
                let player = state.players[index - 1]
                let isActive = state.actions.contains(where: { $0.actorId == player.identifier })
                return PlayerItem(player: player, isActive: isActive)
            }
        }
    }
    
    private func player(at index: Int) -> PlayerProtocol? {
        guard let state = self.state else {
            return nil
        }
        
        let playerIndex = playerIndexes[state.players.count][index] - 1
        guard playerIndex >= 0 else {
            return nil
        }
        
        return state.players[playerIndex]
    }
    
    private var playerIndexes: [[Int]] {
        return [
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 1, 0, 0, 0, 0, 0],
            [0, 0, 0, 1, 0, 2, 0, 0, 0],
            [1, 0, 2, 0, 0, 0, 0, 3, 0],
            [1, 0, 2, 0, 0, 0, 4, 0, 3],
            [1, 2, 3, 0, 0, 0, 5, 0, 4],
            [1, 0, 2, 6, 0, 3, 5, 0, 4],
            [1, 2, 3, 7, 0, 4, 6, 0, 5]
        ]
    }
}
