//
//  ParsedStringValue.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 23/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

@propertyWrapper class ParsedStringValue: ParsableValue {
    
    var wrappedValue: String = ""
    
    func parse(_ data: Any) throws {
        guard let value = data as? String else {
            throw DecodingError.typeMismatch(String.self, DecodingError.Context(codingPath: [], debugDescription: ""))
        }
        
        wrappedValue = value
    }
}
