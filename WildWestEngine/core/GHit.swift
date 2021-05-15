//
//  GHit.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 25/10/2020.
//

public class GHit: HitProtocol {
    
    // MARK: - Properties
    
    public let name: String
    public let player: String
    public let abilities: [String]
    public let offender: String
    public var cancelable: Int
    
    // MARK: - Init
    
    public init(player: String,
                name: String,
                abilities: [String],
                cancelable: Int,
                offender: String) {
        self.player = player
        self.name = name
        self.abilities = abilities
        self.cancelable = cancelable
        self.offender = offender
    }
    
    convenience init(_ hit: HitProtocol) {
        self.init(player: hit.player,
                  name: hit.name, 
                  abilities: hit.abilities,
                  cancelable: hit.cancelable,
                  offender: hit.offender)
    }
}
