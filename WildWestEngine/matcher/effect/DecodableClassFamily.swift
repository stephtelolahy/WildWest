//
//  DecodableClassFamily.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import Foundation
// Decode heterogenous array
// https://nsscreencast.com/episodes/395-decoding-heterogeneous-arrays

/// To support a new class family, create an enum that conforms to this protocol and contains the different types.
protocol DecodableClassFamily: Decodable {
    associatedtype BaseType: Decodable
    
    /// The discriminator key.
    static var discriminator: Discriminator { get }
    
    /// Returns the class type of the object coresponding to the value.
    func getType() -> BaseType.Type
}

/// Discriminator key enum used to retrieve discriminator fields in JSON payloads.
enum Discriminator: String, CodingKey {
    case action
}

extension KeyedDecodingContainer {
    /// Decode a heterogeneous list of objects for a given family.
    /// - Parameters:
    ///     - family: The ClassFamily enum for the type family.
    ///     - key: The CodingKey to look up the list in the current container.
    /// - Returns: The resulting list of heterogeneousType elements.
    func decode<F: DecodableClassFamily>(family: F.Type, forKey key: K) throws -> [F.BaseType] {
        
        var container = try nestedUnkeyedContainer(forKey: key)
        var containerCopy = container
        var items: [F.BaseType] = []
        while !container.isAtEnd {
            
            let typeContainer = try container.nestedContainer(keyedBy: Discriminator.self)
            let family = try typeContainer.decode(F.self, forKey: F.discriminator)
            let type = family.getType()
            // decode type
            let item = try containerCopy.decode(type)
            items.append(item)
        }
        return items
    }
}

extension JSONDecoder {
    /// Decode a heterogeneous list of objects.
    /// - Parameters:
    ///     - family: The ClassFamily enum type to decode with.
    ///     - data: The data to decode.
    /// - Returns: The list of decoded objects.
    func decode<F: DecodableClassFamily>(family: F.Type, from data: Data) throws -> [F.BaseType] {
        try self.decode([ClassWrapper<F>].self, from: data).compactMap { $0.object }
    }
    
    private class ClassWrapper<F: DecodableClassFamily>: Decodable {
        /// The family enum containing the class information.
        let family: F
        /// The decoded object.
        let object: F.BaseType
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: Discriminator.self)
            // Decode the family with the discriminator.
            family = try container.decode(F.self, forKey: F.discriminator)
            // Decode the object by initialising the corresponding type.
            let type = family.getType()
            object = try type.init(from: decoder)
        }
    }
}
