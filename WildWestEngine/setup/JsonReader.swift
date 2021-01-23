//
//  JsonReader.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 29/09/2020.
//

public class JsonReader {
    
    private let bundle: Bundle
    
    public init(bundle: Bundle) {
        self.bundle = bundle
    }
    
    public func load<T: Decodable>(_ file: String) -> T {
        guard let fileURL = bundle.url(forResource: file, withExtension: "json") else {
            fatalError("Json file \(file) not found")
        }
        let decoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: fileURL)
            let model = try decoder.decode(T.self, from: data)
            return model
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

public extension Bundle {
    
    static var resourcesBundle: Bundle {
        Bundle(for: JsonReader.self)
    }
}
