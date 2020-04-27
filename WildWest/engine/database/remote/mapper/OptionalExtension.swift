//
//  OptionalExtension.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 26/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Foundation

/// Unwrap an optional or throws an Error if nil
///
extension Optional {
    func unwrap() throws -> Wrapped {
        guard let value = self else {
            throw UnwrapError()
        }
        return value
    }
}

struct UnwrapError: Error {
}
