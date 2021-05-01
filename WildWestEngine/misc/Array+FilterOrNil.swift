//
//  Array+FilterOrNil.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 27/09/2020.
//

public extension Array {
    
    func filterOrNil(_ predicate: @escaping (Element) -> Bool) -> [Element]? {
        let result = self.filter(predicate)
        guard !result.isEmpty else {
            return nil
        }
        return result
    }
    
    func notEmptyOrNil() -> [Element]? {
        guard !isEmpty else {
            return nil
        }
        return self
    }
    
    func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key: Element] {
        var dict = [Key: Element]()
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
}

public extension Array where Element: Equatable {
    
    func starting(with element: Element?) -> [Element] {
        guard let element = element,
            let elementIndex = firstIndex(of: element) else {
                return self
        }
        
        return (0..<count).map { self[($0 + elementIndex) % count] }
    }

    func combine(by size: Int) -> [[Element]] {
        if size > self.count {
            return []
        }

        if size == self.count {
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
}

public extension Array {
    
    func starting(with predicate: (Element) -> Bool) -> [Element] {
        guard let elementIndex = firstIndex(where: predicate) else {
            return self
        }
        
        return (0..<count).map { self[($0 + elementIndex) % count] }
    }
}
