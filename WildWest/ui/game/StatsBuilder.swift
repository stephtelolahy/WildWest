//
//  StatsBuilder.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 22/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

protocol StatsBuilderProtocol {
    func buildAntiSheriffScore(state: GameStateProtocol) -> [String: Int]
}

class StatsBuilder: StatsBuilderProtocol {
    func buildAntiSheriffScore(state: GameStateProtocol) -> [String: Int] {
        guard let sheriffId = state.allPlayers.first(where: { $0.role == .sheriff })?.identifier else {
            return [:]
        }
        
        var stats: [String: Int] = [:]
        let classifier = MoveClassifier()
        
        state.executedMoves.forEach { move in
            
            let classification = classifier.classify(move)
            switch classification {
            case let .strongAttack(actorId, targetId):
                if targetId == sheriffId {
                    stats.append(Score.strongAttackEnemy, forKey: actorId)
                }
                
            case let .weakAttack(actorId, targetId):
                if targetId == sheriffId {
                    stats.append(Score.weakAttackEnemy, forKey: actorId)
                }
                
            case let .help(actorId, targetId):
                if targetId == sheriffId {
                    stats.append(Score.helpEnemy, forKey: actorId)
                }
                
            default:
                break
            }
        }
        
        return stats
    }
}

private extension Dictionary where Key == String, Value == Int {
    
    mutating func append(_ value: Int, forKey key: String) {
        if let previousValue = self[key] {
            self[key] = previousValue + value
        } else {
            self[key] = value
        }
    }
}
