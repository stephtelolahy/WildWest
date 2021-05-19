//
//  Dictionary+Decoding.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 03/10/2020.
//

// Define DynamicCodingKeys type needed for creating
// decoding container from JSONDecoder
struct DynamicCodingKeys: CodingKey {

    // Use for string-keyed dictionary
    var stringValue: String

    init?(stringValue: String) {
        self.stringValue = stringValue
    }

    // Use for integer-keyed dictionary
    var intValue: Int?

    init?(intValue: Int) {
        // We are not using this, thus just return nil
        return nil
    }
}

extension KeyedDecodingContainer {

    func decode(_ type: [String: Any].Type, forKey key: K) throws -> [String: Any] {
        let container = try self.nestedContainer(keyedBy: DynamicCodingKeys.self, forKey: key)
        return try container.decode(type)
    }

    func decodeIfPresent(_ type: [String: Any].Type, forKey key: K) throws -> [String: Any]? {
        guard contains(key) else {
            return nil
        }
        return try decode(type, forKey: key)
    }

    func decode(_ type: [[String: Any]].Type, forKey key: K) throws -> [[String: Any]] {
        var container = try self.nestedUnkeyedContainer(forKey: key)
        return try container.decode(type)
    }

    func decode(_ type: [String: Any].Type) throws -> [String: Any] {
        var dictionary: [String: Any] = [:]
        for key in allKeys {
            if let boolValue = try? decode(Bool.self, forKey: key) {
                dictionary[key.stringValue] = boolValue
            } else if let stringValue = try? decode(String.self, forKey: key) {
                dictionary[key.stringValue] = stringValue
            } else if let intValue = try? decode(Int.self, forKey: key) {
                dictionary[key.stringValue] = intValue
            } else if let nestedDictionary = try? decode([String: Any].self, forKey: key) {
                dictionary[key.stringValue] = nestedDictionary
            } else if let nestedStringArray = try? decode([String].self, forKey: key) {
                dictionary[key.stringValue] = nestedStringArray
            } else if let nestedDictionaryArray = try? decode([[String: Any]].self, forKey: key) {
                dictionary[key.stringValue] = nestedDictionaryArray
            } else {
                fatalError("Unsupported")
            }
        }
        return dictionary
    }
}

extension UnkeyedDecodingContainer {

    mutating func decode(_ type: [[String: Any]].Type) throws -> [[String: Any]] {
        var array: [[String: Any]] = []
        while isAtEnd == false {
            if let nestedDictionary = try? decode([String: Any].self) {
                array.append(nestedDictionary)
            } else {
                fatalError("Unsupported")
            }
        }
        return array
    }

    mutating func decode(_ type: [String: Any].Type) throws -> [String: Any] {
        let nestedContainer = try self.nestedContainer(keyedBy: DynamicCodingKeys.self)
        return try nestedContainer.decode(type)
    }
}
