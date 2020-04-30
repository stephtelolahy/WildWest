//
//  FirebaseAdapter.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable multiple_closures_with_trailing_closure
// swiftlint:disable multiline_arguments

import RxSwift
import Firebase

protocol FirebaseAdapterProtocol {
    func createGame(_ state: GameStateProtocol, _ completion: @escaping FirebaseStringCompletion)
    func getGame(_ id: String, completion: @escaping FirebaseStateCompletion)
}

class FirebaseAdapter: FirebaseAdapterProtocol {
    
    private let mapper: FirebaseMapperProtocol
    private let keyGenerator: FirebaseKeyGeneratorProtocol
    private let rootRef = Database.database().reference()
    
    init(mapper: FirebaseMapperProtocol,
         keyGenerator: FirebaseKeyGeneratorProtocol) {
        self.mapper = mapper
        self.keyGenerator = keyGenerator
    }
    
    func createGame(_ state: GameStateProtocol, _ completion: @escaping FirebaseStringCompletion) {
        do {
            let key = keyGenerator.gameAutoId()
            let value = try mapper.encodeState(state)
            rootRef.child("games/\(key)/state").setValue(value) { error, _ in
                if let error = error {
                    completion(.error(error))
                } else {
                    completion(.success(key))
                }
            }
            
            rootRef.child("games/\(key)/executedMove").setValue(nil)
            rootRef.child("games/\(key)/executedUpdate").setValue(nil)
            
        } catch {
            completion(.error(error))
        }
    }
    
    func getGame(_ id: String, completion: @escaping FirebaseStateCompletion) {
        rootRef.child("games/\(id)/state").observeSingleEvent(of: .value, with: { snapshot in
            do {
                let state = try self.mapper.decodeState(from: snapshot)
                completion(.success(state))
            } catch {
                completion(.error(error))
            }
        }) { error in
            completion(.error(error))
        }
    }
}
