//
//  DtoEncoder+Challenge.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension DtoEncoder {
    
    func encode(challenge: Challenge?) -> ChallengeDto? {
        guard let challenge = challenge else {
            return nil
        }
        
        return ChallengeDto(name: challenge.name.rawValue,
                            targetIds: challenge.targetIds,
                            damage: challenge.damage,
                            counterNeeded: challenge.counterNeeded,
                            barrelsPlayed: challenge.barrelsPlayed)
    }
    
    func decode(challenge: ChallengeDto?) throws -> Challenge? {
        guard let challenge = challenge else {
            return nil
        }
        
        return try Challenge(name: MoveName(challenge.name.unwrap()),
                             targetIds: challenge.targetIds ?? [],
                             damage: try challenge.damage.unwrap(),
                             counterNeeded: try challenge.counterNeeded.unwrap(),
                             barrelsPlayed: try challenge.barrelsPlayed.unwrap())
    }
}
