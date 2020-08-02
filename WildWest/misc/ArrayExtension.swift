//
//  ArrayExtension.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 31/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

/// unordered combination without repetition
///
extension Array where Element: Equatable {
    
    func combine(by size: Int) -> [[Element]] {
        guard size < self.count else {
            return [self]
        }
        
        guard size > 1 else {
            return self.map { [$0] }
        }
        
        var result: [[Element]] = []
        for array in self.combine(by: size - 1) {
            for element in self.filter({ !array.contains($0) }) {
                if let elementIndex = self.firstIndex(of: element),
                    let lastArrayElement = array.last,
                    let lastArrayIndex = self.firstIndex(of: lastArrayElement),
                    elementIndex > lastArrayIndex {
                    result.append(array + [element])
                }
            }
        }
        return result
    }
    
    func starting(with element: Element?) -> [Element] {
        guard let element = element,
            let elementIndex = firstIndex(of: element) else {
                return self
        }
        
        var result: [Element] = []
        (0..<count).forEach { position in
            let index = (position + elementIndex) % count
            result.append(self[index])
        }
        return result
    }
}

extension Array {
    
    mutating func removeFirst(where shouldBeRemoved: (Element) -> Bool) -> Element? {
        guard let index = self.firstIndex(where: { shouldBeRemoved($0) }) else {
            return nil
        }
        return self.remove(at: index)
    }
    
    func starting(where shouldBeFirst: (Element) -> Bool) -> [Element] {
        guard let elementIndex = self.firstIndex(where: { shouldBeFirst($0) }) else {
            return self
        }
        
        var result: [Element] = []
        (0..<count).forEach { position in
            let index = (position + elementIndex) % count
            result.append(self[index])
        }
        return result
    }
}

extension Array {
    func filterOrNil(_ predicate: @escaping (Element) -> Bool) -> [Element]? {
        let result = self.filter(predicate)
        guard !result.isEmpty else {
            return nil
        }
        return result
    }
}
