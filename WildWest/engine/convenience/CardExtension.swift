//
//  CardExtension.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 1/22/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension CardProtocol {
    
    var isGun: Bool {
        let guns: [CardName] = [.volcanic,
                                .schofield,
                                .remington,
                                .winchester,
                                .revCarbine]
        return guns.contains(name)
    }
    
    var reachableDistance: Int {
        switch name {
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
