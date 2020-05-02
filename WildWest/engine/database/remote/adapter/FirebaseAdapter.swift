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
    func createGame(id: String, state: GameStateProtocol, _ completion: @escaping FirebaseCompletion)
    func getPendingGame(_ id: String, completion: @escaping FirebaseStateCompletion)
}

class FirebaseAdapter: FirebaseAdapterProtocol {
    
    private let mapper: FirebaseMapperProtocol
    private let rootRef = Database.database().reference()
    
    init(mapper: FirebaseMapperProtocol) {
        self.mapper = mapper
    }
    
    func createGame(id: String, state: GameStateProtocol, _ completion: @escaping FirebaseCompletion) {
        do {
            rootRef.child("games/\(id)/executedMove").setValue(nil)
            rootRef.child("games/\(id)/executedUpdate").setValue(nil)
            rootRef.child("games/\(id)/validMoves").setValue(nil)
            rootRef.child("games/\(id)/started").setValue(false)
            let value = try mapper.encodeState(state)
            rootRef.child("games/\(id)/state").setValue(value) { error, _ in
                if let error = error {
                    completion(.error(error))
                } else {
                    completion(.success)
                }
            }
        } catch {
            completion(.error(error))
        }
    }
    
    func getPendingGame(_ id: String, completion: @escaping FirebaseStateCompletion) {
        rootRef.child("games/\(id)/started").observeSingleEvent(of: .value, with: { snapshot in
            let value = snapshot.value as? Bool
            if value == false {
                self.getGame(id, completion: completion)
            } else {
                completion(.error(NSError(domain: "Game is not pending", code: 0)))
            }
        }) { error in
            completion(.error(error))
        }
    }
    
    private func getGame(_ id: String, completion: @escaping FirebaseStateCompletion) {
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
