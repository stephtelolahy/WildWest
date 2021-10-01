//
//  PlayReqFamily.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//
// swiftlint:disable cyclomatic_complexity
// swiftlint:disable switch_case_on_newline

public enum PlayReqFamily: String, CaseIterable {
    
    case isYourTurn
    case isPhase
    case isPlayersCountMin
    case isTimesPerTurnMax
    case isHitEffect
    case isHitCancelable
    case isHitName
    case isHandExceedLimit
    case isHealth
    case isHealthMin
    
    case onHitCancelable
    case onPhase
    case onQueueEmpty
    case onEliminated
    case onOtherEliminated
    case onEliminatingRole
    case onLooseHealth
    case onHandEmpty
    case onPlayCard
    case onPlayCardOutOfTurn
    
    case requireTargetOther
    case requireTargetAny
    case requireTargetAt
    case requireTargetOffender
    case requireTargetEliminated
    case requireTargetHit
    case requireInPlayCard
    case requireHandCards
    case requireHandCardsBlue
    case requireStoreCards
    case requireDeckCards
    
    func getType() -> PlayReq.Type {
        switch self {
        case .isYourTurn: return IsYourTurn.self
        case .isPhase: return IsPhase.self
        case .isPlayersCountMin: return IsPlayersCountMin.self
        case .isHitEffect: return IsHitEffect.self
        case .isHealth: return IsHealth.self
        case .isHealthMin: return IsHealthMin.self
        case .requireTargetOther: return RequireTargetOther.self
        case .requireTargetAny: return RequireTargetAny.self
        case .requireInPlayCard: return RequireInPlayCard.self
        case .requireTargetAt: return RequireTargetAt.self
        case .isTimesPerTurnMax: return IsTimesPerTurnMax.self
        case .isHitCancelable: return IsHitCancelable.self
        case .isHitName: return IsHitName.self
        case .requireStoreCards: return RequireStoreCards.self
        case .onHitCancelable: return OnHitCancelable.self
        case .onPhase: return OnPhase.self
        case .onQueueEmpty: return OnQueueEmpty.self
        case .onEliminated: return OnEliminated.self
        case .onPlayCard: return OnPlayCard.self
        case .onOtherEliminated: return OnOtherEliminated.self
        case .onPlayCardOutOfTurn: return OnPlayCardOutOfTurn.self
        case .isHandExceedLimit: return IsHandExceedLimit.self
        case .requireHandCards: return RequireHandCards.self
        case .requireHandCardsBlue: return RequireHandCardsBlue.self
        case .onEliminatingRole: return OnEliminatingRole.self
        case .onLooseHealth: return OnLooseHealth.self
        case .requireTargetOffender: return RequireTargetOffender.self
        case .onHandEmpty: return OnHandEmpty.self
        case .requireTargetEliminated: return RequireTargetEliminated.self
        case .requireDeckCards: return RequireDeckCards.self
        case .requireTargetHit: return RequireTargetHit.self
        }
    }
}

extension KeyedDecodingContainer {
    
    func decodePlayReqs(forKey key: K) throws -> [PlayReq] {
        guard let dictionary: [String: Any] = try decodeIfPresent([String: Any].self, forKey: key) else {
            return []
        }
        
        let result: [IndexedPlayReq] = try dictionary.map { key, value in
            guard let family = PlayReqFamily(rawValue: key) else {
                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "Unknown key \(key)"))
            }
            
            let index = PlayReqFamily.allCases.firstIndex(of: family)!
            
            let type = family.getType()
            let item = try type.init(value)
            
            return IndexedPlayReq(index: index, req: item)
        }
        
        return result
            .sorted(by: { $0.index < $1.index })
            .map { $0.req }
    }
}

private struct IndexedPlayReq {
    let index: Int
    let req: PlayReq
}
