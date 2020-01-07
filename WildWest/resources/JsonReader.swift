//
//  JsonReader.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

import Foundation

protocol JsonReaderProtocol {
    func load<T: Decodable>(_ class: T.Type, file: String) -> T
}

class JsonReader: JsonReaderProtocol {
    private let bundle: Bundle
    
    init(bundle: Bundle) {
        self.bundle = bundle
    }
    
    func load<T: Decodable>(_ class: T.Type, file: String) -> T {
        do {
            let fileURL = bundle.url(forResource: file, withExtension: "json")!
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let model = try decoder.decode(T.self, from: data)
            return model
        } catch {
            fatalError("cannot load objects")
        }
    }
}
