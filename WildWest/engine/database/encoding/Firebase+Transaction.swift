//
//  Firebase+Transaction.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Firebase

extension Database {
    
    func addGame(_ state: GameStateProtocol) {
        let rootRef = self.reference()
        let gamesRef = rootRef.child("games")
        let gameItemRef = gamesRef.childByAutoId()
        gameItemRef.setValue(state.toEncodable().asDictionary())
    }
}

private extension Encodable {
    func asDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
            .flatMap { $0 as? [String: Any] }
    }
}
