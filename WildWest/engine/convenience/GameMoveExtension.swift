//
//  GameMoveExtension.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 3/17/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension Array where Element == [String: [GameMove]] {
    func merged() -> Element {
        reduce([:], { acc, dict in
            var result = acc
            for (key, value) in dict {
                if let existingValue = result[key] {
                    result[key] = existingValue + value
                } else {
                    result[key] = value
                }
            }
            return result
        })
    }
}
