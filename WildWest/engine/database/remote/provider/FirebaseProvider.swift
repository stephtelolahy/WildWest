//
//  FirebaseProvider.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable multiple_closures_with_trailing_closure
// swiftlint:disable multiline_arguments

import RxSwift
import Firebase

protocol FirebaseProviderProtocol {
    func createGame(_ state: GameStateProtocol) -> String
    func getGame(_ id: String, completion: @escaping ((GameStateProtocol) -> Void))
}

class FirebaseProvider: FirebaseProviderProtocol {
    
    private let mapper: FirebaseMapperProtocol
    private let rootRef = Database.database().reference()
    
    init(mapper: FirebaseMapperProtocol) {
        self.mapper = mapper
    }
    
    func createGame(_ state: GameStateProtocol) -> String {
        //        guard let key = rootRef.child("games").childByAutoId().key else {
        //            fatalError("Unable to create games child")
        //        }
        
        let key = "live"
        
        let value = mapper.encodeState(state)
        rootRef.child("games/\(key)").setValue(value)
        
        return key
    }
    
    func getGame(_ id: String, completion: @escaping ((GameStateProtocol) -> Void)) {
        rootRef.child("games").child(id).observeSingleEvent(of: .value, with: { snapshot in
            let state = self.mapper.decodeState(from: snapshot)
            completion(state)
            
        }) { error in
            fatalError(error.localizedDescription)
        }
    }
}
