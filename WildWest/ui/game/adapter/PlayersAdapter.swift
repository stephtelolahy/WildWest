//
//  PlayersAdapter.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 04/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct PlayerItem {
    let player: PlayerProtocol
    let isTurn: Bool
    let isAttacked: Bool
    let isHelped: Bool
    let score: Int?
}

protocol PlayersAdapterProtocol {
    func buildItems(state: GameStateProtocol,
                    latestMove: GameMove?,
                    scores: [String: Int]) -> [PlayerItem]
}

class PlayersAdapter: PlayersAdapterProtocol {
    
    func buildItems(state: GameStateProtocol,
                    latestMove: GameMove?,
                    scores: [String: Int]) -> [PlayerItem] {
        state.allPlayers.map {
            PlayerItem(player: $0,
                       isTurn: $0.identifier == state.turn,
                       isAttacked: state.isPlayerAttacked($0.identifier) || latestMove?.isPlayerAttacked($0.identifier) == true,
                       isHelped: state.isPlayerHelped($0.identifier) || latestMove?.isPlayerHelped($0.identifier) == true,
                       score: scores[$0.identifier])
        }
    }
}

private extension GameStateProtocol {
    
    func isPlayerAttacked(_ playerId: String) -> Bool {
        if let challenge = self.challenge {
            switch challenge.name {
            case .bang, .gatling, .indians:
                return challenge.targetIds.contains(playerId)
                
            case .duel:
                return challenge.targetIds.first == playerId
                
            case .dynamiteExploded:
                return turn == playerId
                
            default:
                return false
            }
        }
        return false
    }
    
    func isPlayerHelped(_ playerId: String) -> Bool {
        if let challenge = self.challenge {
            switch challenge.name {
            case .generalStore:
                return  challenge.targetIds.contains(playerId)
                
            default:
                return false
            }
        }
        return false
    }
}

private extension GameMove {
    func isPlayerAttacked(_ playerId: String) -> Bool {
        switch MoveClassifier().classify(self) {
        case let .strongAttack(_, targetId):
            return targetId == playerId
            
        case let .weakAttack(_, targetId):
            return targetId == playerId
            
        default:
            return false
        }
    }
    
    func isPlayerHelped(_ playerId: String) -> Bool {
        switch MoveClassifier().classify(self) {
        case let .help(_, targetId):
            return targetId == playerId
            
        default:
            return false
        }
    }
}
