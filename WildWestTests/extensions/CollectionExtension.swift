//
//  CollectionExtension.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 1/23/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Foundation

extension Collection where Element:  Equatable {
    
    func isShuffed(from array: [Element]) -> Bool {
        guard count == array.count,
            filter({ !array.contains($0) }).isEmpty else {
                return false
        }
        
        return true
    }
}
