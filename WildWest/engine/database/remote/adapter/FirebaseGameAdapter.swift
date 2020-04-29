//
//  FirebaseGameAdapter.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 29/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift
import Firebase

protocol FirebaseGameAdapterProtocol {
    func observeExecutedUpdate(_ completion: @escaping FirebaseUpdateCompletion)
    func observeExecutedMove(_ completion: @escaping FirebaseMoveCompletion)
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
        fatalError()
    }
    
    func observeExecutedMove(_ completion: @escaping FirebaseMoveCompletion) {
        fatalError()
    }
    
    func observeValidMoves(_ completion: @escaping FirebaseMovesCompletion) {
        fatalError()
    }
    
    func setExecutedUpdate(_ update: GameUpdate, _ completion: @escaping FirebaseCompletion) {
        fatalError()
    }
    
    func setExecutedMove(_ move: GameMove, _ completion: @escaping FirebaseCompletion) {
        fatalError()
    }
    
    func setValidMoves(_ moves: [GameMove], _ completion: @escaping FirebaseCompletion) {
        fatalError()
    }
}
