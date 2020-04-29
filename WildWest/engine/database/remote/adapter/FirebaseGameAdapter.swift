//
//  FirebaseGameAdapter.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 29/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable multiline_arguments
// swiftlint:disable multiple_closures_with_trailing_closure

import RxSwift
import Firebase

protocol FirebaseGameAdapterProtocol {
    func observeExecutedUpdate(_ completion: @escaping FirebaseUpdateCompletion)
    func observeExecutedMove(_ completion: @escaping FirebaseOptionalMoveCompletion)
    func observeValidMoves(_ completion: @escaping FirebaseMovesCompletion)
    func setExecutedUpdate(_ update: GameUpdate, _ completion: @escaping FirebaseCompletion)
    func setExecutedMove(_ move: GameMove, _ completion: @escaping FirebaseCompletion)
    func setValidMoves(_ moves: [GameMove], _ completion: @escaping FirebaseCompletion)
}

class FirebaseGameAdapter: FirebaseGameAdapterProtocol {
    
    private let gameRef: DatabaseReference
    private let mapper: FirebaseMapperProtocol
    
    init(gameId: String, mapper: FirebaseMapperProtocol) {
        gameRef = Database.database().reference().child("games/\(gameId)")
        self.mapper = mapper
    }
    
    func observeExecutedUpdate(_ completion: @escaping FirebaseUpdateCompletion) {
//        fatalError()
    }
    
    func observeExecutedMove(_ completion: @escaping FirebaseOptionalMoveCompletion) {
        gameRef.child("executedMove").observe(.value, with: { snapshot in
            do {
                let move = try self.mapper.decodeMove(from: snapshot)
                completion(.success(move))
            } catch {
                completion(.error(error))
            }
        }) { error in
            completion(.error(error))
        }
    }
    
    func observeValidMoves(_ completion: @escaping FirebaseMovesCompletion) {
//        fatalError()
    }
    
    func setExecutedUpdate(_ update: GameUpdate, _ completion: @escaping FirebaseCompletion) {
//        fatalError()
    }
    
    func setExecutedMove(_ move: GameMove, _ completion: @escaping FirebaseCompletion) {
        do {
            let value = try mapper.encodeMove(move)
            gameRef.child("executedMove").setValue(value) { error, _ in
                completion(result(from: error))
            }
        } catch {
            completion(.error(error))
        }
    }
    
    func setValidMoves(_ moves: [GameMove], _ completion: @escaping FirebaseCompletion) {
//        fatalError()
    }
}
