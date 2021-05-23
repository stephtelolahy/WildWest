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
    case removeHit
    case discardHand
    case discardInPlay
    case drawHand
    case drawInPlay
    case addHit
    case looseHealth
    
    static var discriminator: Discriminator { .action }
    
    func getType() -> GEffect.Type {
        switch self {
        case .drawDeck: return DrawDeck.self
        case .gainHealth: return GainHealth.self
        case .equip: return Equip.self
        case .handicap: return Handicap.self
        case .setPhase: return SetPhase.self
        case .removeHit: return RemoveHit.self
        case .discardHand: return DiscardHand.self
        case .discardInPlay: return DiscardInPlay.self
        case .drawHand: return DrawHand.self
        case .drawInPlay: return DrawInPlay.self
        case .addHit: return AddHit.self
        case .looseHealth: return LooseHealth.self
        }
    }
}
