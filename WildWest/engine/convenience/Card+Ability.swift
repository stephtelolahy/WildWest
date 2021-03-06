//
//  Card+Ability.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 29/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension CardName {
    
    var isGun: Bool {
        let guns: [CardName] = [.volcanic,
                                .schofield,
                                .remington,
                                .winchester,
                                .revCarbine]
        return guns.contains(self)
    }
    
    var isEquipment: Bool {
        let equipments: [CardName] = [.mustang,
                                      .scope,
                                      .barrel]
        return equipments.contains(self)
    }
    
    var range: Int {
        switch self {
        case .schofield:
            return 2
            
        case .remington:
            return 3
            
        case .revCarbine:
            return 4
            
        case .winchester:
            return 5
            
        default:
            return 1
        }
    }
}

extension CardSuit {
    
    var isRed: Bool {
        switch self {
        case .hearts,
             .diamonds:
            return true
            
        default:
            return false
        }
    }
}

extension CardProtocol {
    
    var makeEscapeFromJail: Bool {
        suit == .hearts
    }
    
    var makeBarrelSuccessful: Bool {
        suit == .hearts
    }
    
    var makeDynamiteExplode: Bool {
        suit == .spades && ["2", "3", "4", "5", "6", "7", "8", "9"].contains(value)
    }
}
