//
//  Player+TargetCard.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 29/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension Array where Element == PlayerProtocol {
    
    func targetableCards() -> [TargetCard]? {
        var result: [TargetCard] = []
        self.forEach { player in
            if !player.hand.isEmpty {
                result.append(TargetCard(ownerId: player.identifier, source: .randomHand))
            }
            result += player.inPlay.map { TargetCard(ownerId: player.identifier, source: .inPlay($0.identifier)) }
        }
        
        guard !result.isEmpty else {
            return nil
        }
        
        return result
    }
}
