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
}
