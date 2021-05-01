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
