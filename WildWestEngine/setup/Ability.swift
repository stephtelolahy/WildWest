//
//  Ability.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 29/09/2020.
//

public struct Ability {
    public let name: String
    public let type: AbilityType
    public let canPlay: [String: Any]
    public let onPlay: [[String: Any]]
    public let priority: Int
}

public enum AbilityType: String {
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
        canPlay = (try? values.decodeIfPresent([String: Any].self, forKey: .canPlay)) ?? [:]
        onPlay = try values.decode([[String: Any]].self, forKey: .onPlay)
        priority = (try? values.decodeIfPresent(Int.self, forKey: .priority)) ?? 1
    }
}

extension AbilityType: Decodable {}
