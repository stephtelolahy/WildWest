//
//  FirebaseStateAdapter.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 26/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable multiple_closures_with_trailing_closure
// swiftlint:disable multiline_arguments

import RxSwift
import Firebase

typealias FirebaseCompletion = (Error?) -> Void
typealias FirebaseCardCompletion = (CardProtocol?, Error?) -> Void

protocol FirebaseStateAdapterProtocol {
    func observe(completion: @escaping ((GameStateProtocol) -> Void))
    func setTurn(_ turn: String, _ completion: @escaping FirebaseCompletion)
    func setChallenge(_ challenge: Challenge?, _ completion: @escaping FirebaseCompletion)
    func playerSetBangsPlayed(_ playerId: String, _ bangsPlayed: Int, _ completion: @escaping FirebaseCompletion)
    func deckRemoveFirst(_ completion: @escaping FirebaseCardCompletion)
    func playerAddHand(_ playerId: String, _ card: CardProtocol, _ completion: @escaping FirebaseCompletion)
    func playerRemoveHand(_ playerId: String, _ cardId: String, _ completion: @escaping FirebaseCardCompletion)
    func playerAddInPlay(_ playerId: String, _ card: CardProtocol, _ completion: @escaping FirebaseCompletion)
}

class FirebaseStateAdapter: FirebaseStateAdapterProtocol {
    
    private let gameId: String
    private let mapper: FirebaseMapperProtocol
    private let rootRef = Database.database().reference()
    
    init(gameId: String, mapper: FirebaseMapperProtocol) {
        self.gameId = gameId
        self.mapper = mapper
    }
    
    func observe(completion: @escaping ((GameStateProtocol) -> Void)) {
        rootRef.child("games").child(gameId).observe(.value, with: { snapshot in
            do {
                let state = try self.mapper.decodeState(from: snapshot)
                completion(state)
            } catch {
                fatalError(error.localizedDescription)
            }
        }) { error in
            fatalError(error.localizedDescription)
        }
    }
    
    func setTurn(_ turn: String, _ completion: @escaping FirebaseCompletion) {
        rootRef.child("games/\(gameId)/turn").setValue(turn) { error, _ in
            completion(error)
        }
    }
    
    func setChallenge(_ challenge: Challenge?, _ completion: @escaping FirebaseCompletion) {
        do {
            let value = try mapper.encodeChallenge(challenge)
            rootRef.child("games/\(gameId)/challenge").setValue(value) { error, _ in
                completion(error)
            }
        } catch {
            completion(error)
        }
    }
    
    func playerSetBangsPlayed(_ playerId: String, _ bangsPlayed: Int, _ completion: @escaping FirebaseCompletion) {
        rootRef.child("games/\(gameId)/players/\(playerId)/bangsPlayed").setValue(bangsPlayed) { error, _ in
            completion(error)
        }
    }
    
    func deckRemoveFirst(_ completion: @escaping FirebaseCardCompletion) {
        rootRef.child("games/\(gameId)/deck").queryLimited(toFirst: 1).observeSingleEvent(of: .value) { snapshot in
            do {
                let (key, card) = try self.mapper.decodeCard(from: snapshot)
                self.rootRef.child("games/\(self.gameId)/deck/\(key)").setValue(nil) { error, _ in
                    completion(card, error)
                }
            } catch {
                completion(nil, error)
            }
        }
    }
    
    func playerAddHand(_ playerId: String, _ card: CardProtocol, _ completion: @escaping FirebaseCompletion) {
        rootRef.child("games/\(gameId)/players/\(playerId)/hand/\(card.identifier)").setValue(true) { error, _ in
            completion(error)
        }
    }
    
    func playerRemoveHand(_ playerId: String, _ cardId: String, _ completion: @escaping FirebaseCardCompletion) {
        rootRef.child("games/\(gameId)/players/\(playerId)/hand/\(cardId)").setValue(nil) { error, _ in
            do {
                let card: CardProtocol = try self.mapper.decodeCard(from: cardId)
                completion(card, error)
            } catch {
                completion(nil, error)
            }
        }
    }
    
    func playerAddInPlay(_ playerId: String, _ card: CardProtocol, _ completion: @escaping FirebaseCompletion) {
        rootRef.child("games/\(gameId)/players/\(playerId)/inPlay/\(card.identifier)").setValue(true) { error, _ in
            completion(error)
        }
    }
}
