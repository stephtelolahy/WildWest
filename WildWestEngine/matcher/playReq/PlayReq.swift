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
    
    public func match(_ ctx: PlayReqContext, args: inout [[PlayArg: [String]]]) -> Bool {
        fatalError("Should be implemented in child class")
    }
}

protocol ParsableValue {
    func parse(_ data: Any) throws
}

public struct PlayReqContext {
    let ability: String
    let actor: PlayerProtocol
    let card: PlayCard?
    let state: StateProtocol
    let event: GEvent?
    var args: [PlayArg: [String]] = [:]
}
