//
//  GHit.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 25/10/2020.
//

public class GHit: HitProtocol {
    
    // MARK: - Properties
    
    public let name: String
    public let abilities: [String]
    public let player: String
    public let offender: String
    public var cancelable: Int
    
    // MARK: - Init
    
    public init(name: String,
                player: String,
                abilities: [String],
                cancelable: Int,
                offender: String) {
        self.name = name
        self.player = player
        self.abilities = abilities
        self.cancelable = cancelable
        self.offender = offender
    }
    
    convenience init(_ hit: HitProtocol) {
        self.init(name: hit.name,
                  player: hit.player, 
                  abilities: hit.abilities,
                  cancelable: hit.cancelable,
                  offender: hit.offender)
    }
}
