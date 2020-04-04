//
//  PlayersAdapter.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 04/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct PlayerItem {
    let player: PlayerProtocol
    let isControlled: Bool
    let isTurn: Bool
    let isAttacked: Bool
    let isHelped: Bool
    let score: Int?
}

protocol PlayersAdapterProtocol {
    func buildItems(state: GameStateProtocol,
                    for controlledPlayerId: String?,
                    antiSheriffScore: [String: Int]) -> [PlayerItem]
}

class PlayersAdapter: PlayersAdapterProtocol {
    
    func buildItems(state: GameStateProtocol,
                    for controlledPlayerId: String?,
                    antiSheriffScore: [String: Int]) -> [PlayerItem] {
        state.players.map {
            PlayerItem(player: $0,
                       isControlled: $0.identifier == controlledPlayerId,
                       isTurn: $0.identifier == state.turn,
                       isAttacked: state.isPlayerAttacked($0.identifier),
                       isHelped: state.isPlayerHelped($0.identifier),
                       score: antiSheriffScore[$0.identifier])
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
        
        let classifier = MoveClassifier()
        if let lastMove = executedMoves.last {
            let classification = classifier.classify(lastMove)
            switch classification {
            case let .strongAttack(_, targetId):
                return targetId == playerId
                
            case let .weakAttack(_, targetId):
                return targetId == playerId
                
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
        
        let classifier = MoveClassifier()
        if let lastMove = executedMoves.last {
            let classification = classifier.classify(lastMove)
            switch classification {
            case let .help(_, targetId):
                return targetId == playerId
                
            default:
                return false
            }
        }
        
        return false
    }
}
