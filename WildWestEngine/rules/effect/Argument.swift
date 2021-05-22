//
//  Argument.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import Foundation

@propertyWrapper class Argument<Value> {
    
    let name: String
    let defaultValue: Value?
    
    private var parsedValue: Value?
    
    init(name: String, defaultValue: Value? = nil) {
        self.name = name
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: Value {
        get {
            parsedValue!
        }
        set {
            parsedValue = newValue
        }
    }
}

struct ArgumentCodingKey: CodingKey {
    var stringValue: String
    var intValue: Int?
    
    init(name: String) {
        stringValue = name
    }
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    init?(intValue: Int) {
        self.intValue = intValue
        self.stringValue = String(intValue)
    }
}

protocol DecodableArgument {
    typealias Container = KeyedDecodingContainer<ArgumentCodingKey>
    func decodeValue(from container: Container) throws
}

extension Argument: DecodableArgument where Value: Decodable {
    
    internal func decodeValue(from container: Container) throws {
        let key = ArgumentCodingKey(name: name)
        
        // We only want to attempt to decode a value if it's present,
        // to enable our app to fall back to its default value
        // in case the flag is missing from our backend data:
        if let value = try container.decodeIfPresent(Value.self, forKey: key) {
            wrappedValue = value
        } else if let defaultValue = defaultValue {
            wrappedValue = defaultValue
        } else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [], debugDescription: "Missing \(name)"))
        }
    }
}

