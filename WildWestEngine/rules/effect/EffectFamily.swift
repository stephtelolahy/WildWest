//
//  EffectFamily.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

enum EffectFamily: String, DecodableClassFamily {
    typealias BaseType = GEffect
    
    case drawDeck
    case gainHealth
    case equip
    case handicap
    case setPhase
    
    static var discriminator: Discriminator { .action }
    
    func getType() -> GEffect.Type {
        switch self {
        case .drawDeck: return DrawDeck.self
        case .gainHealth: return GainHealth.self
        case .equip: return Equip.self
        case .handicap: return Handicap.self
        case .setPhase: return SetPhase.self
        }
    }
}
