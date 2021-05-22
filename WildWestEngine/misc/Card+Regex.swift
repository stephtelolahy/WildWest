//
//  Card+Regex.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 09/10/2020.
//

public extension CardProtocol {
    
    func matches(regex pattern: String) -> Bool {
        let cardString = "\(value)\(suit)"
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            return false
        }
        
        let range = NSRange(location: 0, length: cardString.utf16.count)
        return regex.firstMatch(in: cardString, options: [], range: range) != nil
    }
}
