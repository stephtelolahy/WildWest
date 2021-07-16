//
//  Card+Regex.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 09/10/2020.
//

public extension CardProtocol {
    
    func matches(regex pattern: String) -> Bool {
        "\(name)\(value)\(suit)".matches(regex: pattern)
    }
}

public  extension String {
    
    func matches(regex pattern: String) -> Bool {
        if pattern.isEmpty {
            return true
        }
        
        let string = self
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            return false
        }
        
        let range = NSRange(location: 0, length: string.utf16.count)
        return regex.firstMatch(in: string, options: [], range: range) != nil
    }
}
