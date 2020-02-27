//
//  PlayersAdapter.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 04/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct PlayerItem {
    let player: PlayerProtocol
    let isActive: Bool
    let isTurn: Bool
    let isEliminated: Bool
    let isRevealed: Bool
    let isControlled: Bool
}

protocol PlayersAdapterProtocol {
    var items: [PlayerItem?] { get }
    
    func setState(_ state: GameStateProtocol)
    func setControlledPlayerId(_ identifier: String?)
}

class PlayersAdapter: PlayersAdapterProtocol {
    
    var items: [PlayerItem?] = []
    
    private var state: GameStateProtocol?
    private var playerIndexes: [Int: String?] = [:]
    private var controlledPlayerId: String?
    
    func setState(_ state: GameStateProtocol) {
        if self.state == nil {
            playerIndexes = MapConfiguration.buildIndexes(with: state)
        }
        
        self.state = state
        items = buildItems()
    }
    
    func setControlledPlayerId(_ identifier: String?) {
        controlledPlayerId = identifier
        items = buildItems()
    }
    
    private func buildItems() -> [PlayerItem?] {
        guard let state = self.state else {
            return []
        }
        
        return Array(0..<MapConfiguration.itemsCount).map { index in
            guard let playerId = playerIndexes[index] else {
                return nil
            }
            
            if let eliminatedPlayer = state.eliminated.first(where: { $0.identifier == playerId }) {
                return PlayerItem(player: eliminatedPlayer,
                                  isActive: false,
                                  isTurn: false,
                                  isEliminated: true,
                                  isRevealed: true,
                                  isControlled: false)
            }
            
            if let player = state.players.first(where: { $0.identifier == playerId }) {
                let isActive = state.validMoves.contains(where: { $0.actorId == playerId })
                let isTurn = player.identifier == state.turn
                let isRevealed = state.outcome != nil
                    || player.role == .sheriff
                    || player.identifier == controlledPlayerId
                return PlayerItem(player: player,
                                  isActive: isActive,
                                  isTurn: isTurn,
                                  isEliminated: false,
                                  isRevealed: isRevealed,
                                  isControlled: player.identifier == controlledPlayerId)
            }
            
            return nil
        }
    }
}

private enum MapConfiguration {
    
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
