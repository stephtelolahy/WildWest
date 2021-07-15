//
//  PlayReq.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

public class PlayReq {
    
    public required init(_ data: Any) throws {
        for child in Mirror(reflecting: self).children {
            guard let argument = child.value as? ParsableValue else {
                continue
            }
            
            try argument.parse(data)
        }
    }
    
    public func match(_ ctx: PlayContext, args: inout [[PlayArg: [String]]]) -> Bool {
        fatalError("Should be implemented in child class")
    }
}

protocol ParsableValue {
    func parse(_ data: Any) throws
}
