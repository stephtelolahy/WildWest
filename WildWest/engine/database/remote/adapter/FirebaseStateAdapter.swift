//
//  FirebaseStateAdapter.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 26/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable multiple_closures_with_trailing_closure
// swiftlint:disable multiline_arguments
// swiftlint:disable type_body_length

import RxSwift
import Firebase

protocol FirebaseStateAdapterProtocol {
    func observeState(_ completion: @escaping FirebaseStateCompletion)
    func setTurn(_ turn: String, _ completion: @escaping FirebaseCompletion)
    func setChallenge(_ challenge: Challenge?, _ completion: @escaping FirebaseCompletion)
    func playerSetBangsPlayed(_ playerId: String, _ bangsPlayed: Int, _ completion: @escaping FirebaseCompletion)
    func deckRemoveFirst(_ completion: @escaping FirebaseCardCompletion)
    func playerAddHand(_ playerId: String, _ card: CardProtocol, _ completion: @escaping FirebaseCompletion)
    func playerRemoveHand(_ playerId: String, _ cardId: String, _ completion: @escaping FirebaseCardCompletion)
    func playerAddInPlay(_ playerId: String, _ card: CardProtocol, _ completion: @escaping FirebaseCompletion)
    func playerRemoveInPlay(_ playerId: String, _ cardId: String, _ completion: @escaping FirebaseCardCompletion)
    func playerSetHealth(_ playerId: String, _ health: Int, _ completion: @escaping FirebaseCompletion)
    func playerSetDamageEvent(_ playerId: String, _ event: DamageEvent, _ completion: @escaping FirebaseCompletion)
    func setOutcome(_ outcome: GameOutcome, _ completion: @escaping FirebaseCompletion)
    func addDiscard(_ card: CardProtocol, _ completion: @escaping FirebaseCompletion)
    func addGeneralStore(_ card: CardProtocol, _ completion: @escaping FirebaseCompletion)
    func removeGeneralStore(_ cardId: String, _ completion: @escaping FirebaseCardCompletion)
    func resetDeck(when minSize: Int, _ completion: @escaping FirebaseCompletion)
}

class FirebaseStateAdapter: FirebaseStateAdapterProtocol {
    
    private let gameId: String
    private let mapper: FirebaseMapperProtocol
    private let rootRef = Database.database().reference()
    
    init(gameId: String, mapper: FirebaseMapperProtocol) {
        self.gameId = gameId
        self.mapper = mapper
    }
    
    func observeState(_ completion: @escaping FirebaseStateCompletion) {
        rootRef.child("games").child(gameId).observe(.value, with: { snapshot in
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
    
    func setTurn(_ turn: String, _ completion: @escaping FirebaseCompletion) {
        rootRef.child("games/\(gameId)/turn").setValue(turn) { error, _ in
            completion(result(from: error))
        }
    }
    
    func setChallenge(_ challenge: Challenge?, _ completion: @escaping FirebaseCompletion) {
        do {
            let value = try mapper.encodeChallenge(challenge)
            rootRef.child("games/\(gameId)/challenge").setValue(value) { error, _ in
                completion(result(from: error))
            }
        } catch {
            completion(.error(error))
        }
    }
    
    func playerSetBangsPlayed(_ playerId: String, _ bangsPlayed: Int, _ completion: @escaping FirebaseCompletion) {
        rootRef.child("games/\(gameId)/players/\(playerId)/bangsPlayed").setValue(bangsPlayed) { error, _ in
            completion(result(from: error))
        }
    }
    
    func deckRemoveFirst(_ completion: @escaping FirebaseCardCompletion) {
        rootRef.child("games/\(gameId)/deck").queryLimited(toFirst: 1).observeSingleEvent(of: .value) { snapshot in
            do {
                let (key, card) = try self.mapper.decodeCard(from: snapshot)
                self.rootRef.child("games/\(self.gameId)/deck/\(key)").setValue(nil) { error, _ in
                    if let error = error {
                        completion(.error(error))
                    } else {
                        completion(.success(card))
                    }
                }
            } catch {
                completion(.error(error))
            }
        }
    }
    
    func playerAddHand(_ playerId: String, _ card: CardProtocol, _ completion: @escaping FirebaseCompletion) {
        rootRef.child("games/\(gameId)/players/\(playerId)/hand/\(card.identifier)").setValue(true) { error, _ in
            completion(result(from: error))
        }
    }
    
    func playerRemoveHand(_ playerId: String, _ cardId: String, _ completion: @escaping FirebaseCardCompletion) {
        rootRef.child("games/\(gameId)/players/\(playerId)/hand/\(cardId)").setValue(nil) { error, _ in
            do {
                let card: CardProtocol = try self.mapper.decodeCard(from: cardId)
                completion(.success(card))
            } catch {
                completion(.error(error))
            }
        }
    }
    
    func playerAddInPlay(_ playerId: String, _ card: CardProtocol, _ completion: @escaping FirebaseCompletion) {
        rootRef.child("games/\(gameId)/players/\(playerId)/inPlay/\(card.identifier)").setValue(true) { error, _ in
            completion(result(from: error))
        }
    }
    
    func playerRemoveInPlay(_ playerId: String, _ cardId: String, _ completion: @escaping FirebaseCardCompletion) {
        rootRef.child("games/\(gameId)/players/\(playerId)/inPlay/\(cardId)").setValue(nil) { error, _ in
            do {
                let card: CardProtocol = try self.mapper.decodeCard(from: cardId)
                completion(.success(card))
            } catch {
                completion(.error(error))
            }
        }
    }
    
    func playerSetHealth(_ playerId: String, _ health: Int, _ completion: @escaping FirebaseCompletion) {
        rootRef.child("games/\(gameId)/players/\(playerId)/health").setValue(health) { error, _ in
            completion(result(from: error))
        }
    }
    
    func playerSetDamageEvent(_ playerId: String, _ event: DamageEvent, _ completion: @escaping FirebaseCompletion) {
        do {
            let value = try mapper.encodeDamageEvent(event)
            rootRef.child("games/\(gameId)/players/\(playerId)/lastDamage").setValue(value) { error, _ in
                completion(result(from: error))
            }
        } catch {
            completion(.error(error))
        }
    }
    
    func setOutcome(_ outcome: GameOutcome, _ completion: @escaping FirebaseCompletion) {
        rootRef.child("games/\(gameId)/outcome").setValue(outcome.rawValue) { error, _ in
            completion(result(from: error))
        }
    }
    
    func addDiscard(_ card: CardProtocol, _ completion: @escaping FirebaseCompletion) {
        rootRef.child("games/\(gameId)/discardPile").childByAutoId().setValue(card.identifier) { error, _ in
            completion(result(from: error))
        }
    }
    
    func addGeneralStore(_ card: CardProtocol, _ completion: @escaping FirebaseCompletion) {
        rootRef.child("games/\(gameId)/generalStore/\(card.identifier)").setValue(true) { error, _ in
            completion(result(from: error))
        }
    }
    
    func removeGeneralStore(_ cardId: String, _ completion: @escaping FirebaseCardCompletion) {
        rootRef.child("games/\(gameId)/generalStore/\(cardId)").setValue(nil) { error, _ in
            do {
                let card: CardProtocol = try self.mapper.decodeCard(from: cardId)
                completion(.success(card))
            } catch {
                completion(.error(error))
            }
        }
    }
    
    func resetDeck(when minSize: Int, _ completion: @escaping FirebaseCompletion) {
        let limit = UInt(minSize + 1)
        rootRef.child("games/\(gameId)/deck").queryLimited(toFirst: limit).observeSingleEvent(of: .value) { snapshot in
            do {
                let dictionary = try (snapshot.value as? [String: String]).unwrap()
                guard dictionary.keys.count <= minSize else {
                    completion(.success)
                    return
                }
                
                let deckCards = try self.mapper.decodeCards(from: snapshot)
                
                let query = self.rootRef.child("games/\(self.gameId)/discardPile").queryOrderedByKey()
                query.observeSingleEvent(of: .value) { snapshot in
                    do {
                        let cards = try self.mapper.decodeCards(from: snapshot)
                        
                        let deck = (deckCards + Array(cards[1..<cards.count])).shuffled()
                        let discard = Array(cards[0..<1])
                        
                        self.setDeck(deck, discards: discard, completion: completion)
                        
                    } catch {
                        completion(.error(error))
                    }
                }
                
            } catch {
                completion(.error(error))
            }
        }
    }
}

private extension FirebaseStateAdapter {
    
    func setDeck(_ deckCards: [CardProtocol], discards: [CardProtocol], completion: @escaping FirebaseCompletion) {
        setDeck(deckCards) { result in
            switch result {
            case .success:
                self.setDiscardPile(discards, completion)
                
            case let .error(error):
                completion(.error(error))
            }
        }
    }
    
    func setDeck(_ cards: [CardProtocol], _ completion: @escaping FirebaseCompletion) {
        do {
            let value = try mapper.encodeOrderedCards(cards)
            rootRef.child("games/\(gameId)/deck").setValue(value)
            completion(.success)
        } catch {
            completion(.error(error))
        }
    }
    
    func setDiscardPile(_ cards: [CardProtocol], _ completion: @escaping FirebaseCompletion) {
        do {
            let value = try mapper.encodeOrderedCards(cards.reversed())
            rootRef.child("games/\(gameId)/discardPile").setValue(value)
            completion(.success)
        } catch {
            completion(.error(error))
        }
    }
    
}
