//
//  Ability.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

public struct Ability {
    public let name: String
    public let type: AbilityType
    public let canPlay: [PlayReq]
    public let onPlay: [Effect]
    public let priority: Int
}

public enum AbilityType: String, Decodable {
    case active
    case triggered
}

extension Ability: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case name
        case type
        case canPlay
        case onPlay
        case priority
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        type = try values.decode(AbilityType.self, forKey: .type)
        canPlay = try values.decodePlayReqs(forKey: .canPlay)
        onPlay = try values.decode(family: EffectFamily.self, forKey: .onPlay)
        priority = (try? values.decodeIfPresent(Int.self, forKey: .priority)) ?? 1
    }
}
