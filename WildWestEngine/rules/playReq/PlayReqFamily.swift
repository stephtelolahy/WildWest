//
//  PlayReqFamily.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

enum PlayReqFamily: String, CaseIterable {
    
    case isYourTurn
    case isPhase
    case isPlayersCountMin
    case isTimesPerTurnMax
    case isHitEliminate
    case isHitCancelable
    case isHitName
    
    case onHitCancelable
    case onPhase
    case onQueueEmpty
    
    case requireTargetAny
    case requireTargetSelf
    case requireTargetAt
    case requireTargetReachable
    case requireInPlayCard
    case requireStoreCards
    
    func getType() -> GPlayReq.Type {
        switch self {
        case .isYourTurn: return IsYourTurn.self
        case .isPhase: return IsPhase.self
        case .isPlayersCountMin: return IsPlayersCountMin.self
        case .isHitEliminate: return IsHitEliminate.self
        case .requireTargetAny: return RequireTargetAny.self
        case .requireInPlayCard: return RequireInPlayCard.self
        case .requireTargetSelf: return RequireTargetSelf.self
        case .requireTargetAt: return RequireTargetAt.self
        case .requireTargetReachable: return RequireTargetReachable.self
        case .isTimesPerTurnMax: return IsTimesPerTurnMax.self
        case .isHitCancelable: return IsHitCancelable.self
        case .isHitName: return IsHitName.self
        case .requireStoreCards: return RequireStoreCards.self
        case .onHitCancelable: return OnHitCancelable.self
        case .onPhase: return OnPhase.self
        case .onQueueEmpty: return OnQueueEmpty.self
        }
    }
}

extension KeyedDecodingContainer {
    
    func decodePlayReqs(forKey key: K) throws -> [GPlayReq] {
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
    let req: GPlayReq
}
