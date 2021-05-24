//
//  EffectFamily.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//
// swiftlint:disable cyclomatic_complexity
// swiftlint:disable switch_case_on_newline

enum EffectFamily: String, DecodableClassFamily {
    typealias BaseType = Effect
    
    case drawDeck
    case gainHealth
    case equip
    case handicap
    case setPhase
    case setTurn
    case removeHit
    case discardHand
    case discardInPlay
    case drawHand
    case drawInPlay
    case addHit
    case looseHealth
    case cancelHit
    case reverseHit
    case deckToStore
    case drawStore
    case flipDeckIf
    case passInPlay
    case drawDeckFlippingIf
    case drawDeckChoosing
    case drawDiscard
    
    static var discriminator: Discriminator { .action }
    
    func getType() -> Effect.Type {
        switch self {
        case .drawDeck: return DrawDeck.self
        case .gainHealth: return GainHealth.self
        case .equip: return Equip.self
        case .handicap: return Handicap.self
        case .setPhase: return SetPhase.self
        case .setTurn: return SetTurn.self
        case .removeHit: return RemoveHit.self
        case .discardHand: return DiscardHand.self
        case .discardInPlay: return DiscardInPlay.self
        case .drawHand: return DrawHand.self
        case .drawInPlay: return DrawInPlay.self
        case .addHit: return AddHit.self
        case .looseHealth: return LooseHealth.self
        case .cancelHit: return CancelHit.self
        case .reverseHit: return ReverseHit.self
        case .deckToStore: return DeckToStore.self
        case .drawStore: return DrawStore.self
        case .flipDeckIf: return FlipDeckIf.self
        case .passInPlay: return PassInPlay.self
        case .drawDeckFlippingIf: return DrawDeckFlippingIf.self
        case .drawDeckChoosing: return DrawDeckChoosing.self
        case .drawDiscard: return DrawDiscard.self
        }
    }
}
