//
//  ParsedIntValue.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

@propertyWrapper class ParsedIntValue {
    
    private var parsedValue: Int = 0
    
    var wrappedValue: Int {
        get {
            parsedValue
        }
        set {
        }
    }
    
    func parse(_ data: Any) throws {
        guard let value = data as? Int else {
            throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: [], debugDescription: ""))
        }
        
        parsedValue = value
    }
}
