//
//  TargetCard+Description.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension TargetCard {
    var description: String {
        switch source {
        case .randomHand:
            return "\(ownerId)'s random hand"
        case let .inPlay(targetCardId):
            return "\(ownerId)'s \(targetCardId)"
        }
    }
}
