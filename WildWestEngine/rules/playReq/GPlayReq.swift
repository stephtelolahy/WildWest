//
//  GPlayReq.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

public class GPlayReq {
    
    public required init(_ data: Any) throws {
        for child in Mirror(reflecting: self).children {
            if let argument = child.value as? ParsedIntValue {
                try argument.parse(data)
            } else {
                continue
            }
        }
    }
    
    public func match(_ ctx: PlayReqContext, args: inout [[PlayArg: [String]]]) -> Bool {
        fatalError("Should be implemented in child class")
    }
}
