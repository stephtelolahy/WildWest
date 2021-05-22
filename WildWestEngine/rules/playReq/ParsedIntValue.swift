//
//  ParsedIntValue.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

@propertyWrapper class ParsedIntValue {
    
    var wrappedValue: Int = 0
    
    func parse(_ data: Any) throws {
        guard let value = data as? Int else {
            throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: [], debugDescription: ""))
        }
        
        wrappedValue = value
    }
}
