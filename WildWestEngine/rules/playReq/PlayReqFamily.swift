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
    case requireTargetAny
    case isHitEliminate
    
    func getType() -> GPlayReq.Type {
        switch self {
        case .isYourTurn: return IsYourTurn.self
        case .isPhase: return IsPhase.self
        case .isPlayersCountMin: return IsPlayersCountMin.self
        case .isHitEliminate: return IsHitEliminate.self
        case .requireTargetAny: return RequireTargetAny.self
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
