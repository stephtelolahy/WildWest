//
//  Argument.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import Foundation

@propertyWrapper class Argument<T> {
    
    private let name: String
    private let defaultValue: T?
    private var parsedValue: T?
    
    init(name: String, defaultValue: T? = nil) {
        self.name = name
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        parsedValue ?? defaultValue!
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

extension Argument: DecodableArgument where T: Decodable {
    
    internal func decodeValue(from container: Container) throws {
        let key = ArgumentCodingKey(name: name)
        
        // Decode [Effect]
        if T.self == [Effect].self {
            if container.contains(key) {
                parsedValue = try container.decode(family: EffectFamily.self, forKey: key) as? T
            }
            return
        }
        
        // We only want to attempt to decode a value if it's present,
        // to enable our app to fall back to its default value
        // in case the flag is missing from our backend data:
        if let value = try container.decodeIfPresent(T.self, forKey: key) {
            parsedValue = value
        } else if let defaultValue = defaultValue {
            parsedValue = defaultValue
        } else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: [], debugDescription: "Missing \(name)"))
        }
    }
}
