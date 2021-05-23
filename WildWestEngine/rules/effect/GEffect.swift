//
//  GEffect.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

public class GEffect: Decodable {
    
    @Argument(name: "optional", defaultValue: false)
    var optional: Bool
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ArgumentCodingKey.self)
        
        for child in Mirror(reflecting: self).children {
            guard let argument = child.value as? DecodableArgument else {
                continue
            }
            try argument.decodeValue(from: container)
        }
        
        for child in Mirror(reflecting: self).superclassMirror!.children {
            guard let argument = child.value as? DecodableArgument else {
                continue
            }
            try argument.decodeValue(from: container)
        }
    }
    
    func apply(_ ctx: EffectContext) -> [GEvent]? {
        fatalError("Should be implemented in child class")
    }
}
