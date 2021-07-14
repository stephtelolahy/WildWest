//
//  GHit.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 25/10/2020.
//

public struct GHit: HitProtocol, Equatable {
    
    // MARK: - Properties
    
    public let player: String
    public let name: String
    public let abilities: [String]
    public let offender: String
    public let cancelable: Int
    public let target: String?
    
    // MARK: - Init
    
    public init(player: String,
                name: String,
                abilities: [String],
                offender: String,
                cancelable: Int = 0,
                target: String? = nil) {
        self.player = player
        self.name = name
        self.abilities = abilities
        self.offender = offender
        self.cancelable = cancelable
        self.target = target
    }
}
