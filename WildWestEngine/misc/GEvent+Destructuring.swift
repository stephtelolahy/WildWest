//
//  GEvent+Destructuring.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 21/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import Foundation

public extension GEvent {
    
    var name: String {
        var string = String(describing: self)
        if let eventName = string.components(separatedBy: "(").first {
            string = eventName
        }
        return string
    }
    
    func destructuring() -> [String: String] {
        switch self {
        case let .run(move):
            return ["event": name,
                    "ability": move.ability]
            
        case let .addHit(_, ability, _, _, _):
            return ["event": name,
                    "ability": ability]
            
        default:
            return ["event": name]
        }
    }
}
