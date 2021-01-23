//
//  DefaultAbilities.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 22/11/2020.
//

public struct DefaultAbilities: Decodable {
    public let common: [String: Int]
    public let sheriff: [String: Int]
    
    public init(common: [String: Int],
                sheriff: [String: Int]) {
        self.common = common
        self.sheriff = sheriff
    }
}
