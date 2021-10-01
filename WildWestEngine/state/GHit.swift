//
//  GHit.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 25/10/2020.
//

public struct GHit: HitProtocol, Equatable {
    
    // MARK: - Properties
    
    public let name: String
    public var players: [String]
    public let abilities: [String]
    public var cancelable: Int
    public var targets: [String]
    
    // MARK: - Init
    
    public init(name: String,
                players: [String],
                abilities: [String],
                cancelable: Int = 0,
                targets: [String] = []) {
        self.name = name
        self.players = players
        self.abilities = abilities
        self.cancelable = cancelable
        self.targets = targets
    }
}
