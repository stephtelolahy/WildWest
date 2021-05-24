//
//  parsedValue.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 23/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

@propertyWrapper class ParsedValue<T>: ParsableValue {
    
    private var parsedValue: T?
    
    var wrappedValue: T {
        parsedValue!
    }
    
    func parse(_ data: Any) throws {
        
        // Parse Enum
        if T.self == NumberArgument.self {
            guard let rawValue = data as? String,
                  let value = NumberArgument(rawValue: rawValue) else {
                throw DecodingError.typeMismatch(NumberArgument.self, DecodingError.Context(codingPath: [], debugDescription: ""))
            }
            
            parsedValue = value as? T
            return
        }
        
        if T.self == Role.self {
            guard let rawValue = data as? String,
                  let value = Role(rawValue: rawValue) else {
                throw DecodingError.typeMismatch(Role.self, DecodingError.Context(codingPath: [], debugDescription: ""))
            }
            
            parsedValue = value as? T
            return
        }
                
        guard let value = data as? T else {
            throw DecodingError.typeMismatch(T.self, DecodingError.Context(codingPath: [], debugDescription: ""))
        }
        
        parsedValue = value
    }
}
