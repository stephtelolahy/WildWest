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
    private var playerIdentifierByIndex: [Int: String?] = [:]
    
    func setState(_ state: GameStateProtocol) {
        if self.state == nil {
            playerIdentifierByIndex = PlayerIndexBuilder.buildIndexes(with: state)
        }
        
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
        
        return Array(0..<PlayerIndexBuilder.itemsCount).map { index in
            guard let playerId = playerIdentifierByIndex[index],
                let player = state.players.first(where: { $0.identifier == playerId }) else {
                    return PlayerItem(player: nil, isActive: false)
            }
            
            let isActive = state.actions.contains(where: { $0.actorId == playerId })
            return PlayerItem(player: player, isActive: isActive)
        }
    }
}

enum PlayerIndexBuilder {
    
    static let itemsCount = 9
    
    static func buildIndexes(with state: GameStateProtocol) -> [Int: String?] {
        let configuration: [[Int]] = [
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 1, 0, 0, 0, 0, 0],
            [0, 0, 0, 1, 0, 2, 0, 0, 0],
            [1, 0, 2, 0, 0, 0, 0, 3, 0],
            [1, 0, 2, 0, 0, 0, 4, 0, 3],
            [1, 2, 3, 0, 0, 0, 5, 0, 4],
            [1, 0, 2, 6, 0, 3, 5, 0, 4],
            [1, 2, 3, 7, 0, 4, 6, 0, 5]
        ]
        
        var result: [Int: String?] = [:]
        let indexes = configuration[state.players.count]
        for (index, element) in indexes.enumerated() {
            if element > 0 {
                let player = state.players[element - 1]
                result[index] = player.identifier
            } else {
                result[index] = nil
            }
        }
        
        return result
    }
}
