//
//  FirebaseKeyGenerator.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 26/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Firebase

class FirebaseKeyGenerator: KeyGeneratorProtocol {
    
    private let rootRef = Database.database().reference()
    
    func cardAutoId() -> String {
        guard let key = rootRef.child("games/live/deck").childByAutoId().key else {
            fatalError("Cannot get autogenerated unique identifier")
        }
        
        return key
    }
}
