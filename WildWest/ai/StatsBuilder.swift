//
//  StatsBuilder.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 22/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

protocol StatsBuilderProtocol {
    var scores: [String: Int] { get }
    
    func updateOnExecuting(_ move: GameMove)
}

class StatsBuilder: StatsBuilderProtocol {
    
    var scores: [String: Int] = [:]
    
    private let sheriffId: String
    private let classifier: MoveClassifierProtocol
    
    init(sheriffId: String, classifier: MoveClassifierProtocol) {
        self.sheriffId = sheriffId
        self.classifier = classifier
    }
    
    func updateOnExecuting(_ move: GameMove) {
        let classification = classifier.classify(move)
        switch classification {
        case let .strongAttack(actorId, targetId):
            if targetId == sheriffId {
                scores.append(Score.strongAttackEnemy, forKey: actorId)
            }
            
        case let .weakAttack(actorId, targetId):
            if targetId == sheriffId {
                scores.append(Score.weakAttackEnemy, forKey: actorId)
            }
            
        case let .help(actorId, targetId):
            if targetId == sheriffId {
                scores.append(Score.helpEnemy, forKey: actorId)
            }
            
        default:
            break
        }
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
