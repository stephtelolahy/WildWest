//
//  CardExtension.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 1/22/20.
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
    
    var reachableDistance: Int {
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

extension CardProtocol {
    
    var makeEscapeFromJail: Bool {
        suit == .hearts
    }
    
    var makeDynamiteExplode: Bool {
        suit == .spades && ["2", "3", "4", "5", "6", "7", "8", "9"].contains(value)
    }
    
    var makeBarrelWork: Bool {
        suit == .hearts
    }
}
