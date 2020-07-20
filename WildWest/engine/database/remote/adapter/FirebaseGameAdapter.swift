//
//  FirebaseGameAdapter.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 29/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable multiline_arguments
// swiftlint:disable multiple_closures_with_trailing_closure
// swiftlint:disable type_body_length

import RxSwift
import Firebase

protocol FirebaseGameAdapterProtocol {
    func observeState(_ completion: @escaping FirebaseStateCompletion)
    func observeExecutedUpdate(_ completion: @escaping FirebaseUpdateCompletion)
    func observeExecutedMove(_ completion: @escaping FirebaseMoveCompletion)
    func observeValidMoves(_ completion: @escaping FirebaseMovesCompletion)
    func observeStarted(_ completion: @escaping FirebaseBooleanCompletion)
    
    func setExecutedUpdate(_ update: GameUpdate, _ completion: @escaping FirebaseCompletion)
    func setExecutedMove(_ move: GameMove, _ completion: @escaping FirebaseCompletion)
    func setValidMoves(_ moves: [GameMove], _ completion: @escaping FirebaseCompletion)
    func setStarted(_ completion: @escaping FirebaseCompletion)
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

class FirebaseGameAdapter: FirebaseGameAdapterProtocol {
    
    private let gameRef: DatabaseReference
    private let stateRef: DatabaseReference
    private let mapper: FirebaseMapperProtocol
    
    init(gameId: String, mapper: FirebaseMapperProtocol) {
        gameRef = Database.database().reference().child("games/\(gameId)")
        stateRef = Database.database().reference().child("games/\(gameId)/state")
        self.mapper = mapper
    }
    
    func observeState(_ completion: @escaping FirebaseStateCompletion) {
        stateRef.observe(.value, with: { snapshot in
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
    
    func observeExecutedUpdate(_ completion: @escaping FirebaseUpdateCompletion) {
        gameRef.child("executedUpdate").observe(.value, with: { snapshot in
            do {
                guard let update = try self.mapper.decodeUpdate(from: snapshot) else {
                    return
                }
                completion(.success(update))
            } catch {
                completion(.error(error))
            }
        }) { error in
            completion(.error(error))
        }
    }
    
    func observeExecutedMove(_ completion: @escaping FirebaseMoveCompletion) {
        gameRef.child("executedMove").observe(.value, with: { snapshot in
            do {
                guard let move = try self.mapper.decodeMove(from: snapshot) else {
                    return
                }
                completion(.success(move))
            } catch {
                completion(.error(error))
            }
        }) { error in
            completion(.error(error))
        }
    }
    
    func observeValidMoves(_ completion: @escaping FirebaseMovesCompletion) {
        gameRef.child("validMoves").observe(.value, with: { snapshot in
            do {
                let moves = try self.mapper.decodeMoves(from: snapshot)
                completion(.success(moves))
            } catch {
                completion(.error(error))
            }
        }) { error in
            completion(.error(error))
        }
    }
    
    func observeStarted(_ completion: @escaping FirebaseBooleanCompletion) {
        gameRef.child("started").observe(.value, with: { snapshot in
            do {
                let value = try (snapshot.value as? Bool).unwrap()
                completion(.success(value))
            } catch {
                completion(.error(error))
            }
        }) { error in
            completion(.error(error))
        }
    }
    
    func setExecutedUpdate(_ update: GameUpdate, _ completion: @escaping FirebaseCompletion) {
        do {
            let value = try mapper.encodeUpdate(update)
            gameRef.child("executedUpdate").setValue(value) { error, _ in
                completion(result(from: error))
            }
        } catch {
            completion(.error(error))
        }
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
        do {
            let value = try mapper.encodeMoves(moves)
            gameRef.child("validMoves").setValue(value) { error, _ in
                completion(result(from: error))
            }
        } catch {
            completion(.error(error))
        }
    }
    
    func setStarted(_ completion: @escaping FirebaseCompletion) {
        gameRef.child("started").setValue(true) { error, _ in
            completion(result(from: error))
        }
    }
    
    func setTurn(_ turn: String, _ completion: @escaping FirebaseCompletion) {
        stateRef.child("turn").setValue(turn) { error, _ in
            completion(result(from: error))
        }
    }
    
    func setChallenge(_ challenge: Challenge?, _ completion: @escaping FirebaseCompletion) {
        do {
            let value = try mapper.encodeChallenge(challenge)
            stateRef.child("challenge").setValue(value) { error, _ in
                completion(result(from: error))
            }
        } catch {
            completion(.error(error))
        }
    }
    
    func playerSetBangsPlayed(_ playerId: String, _ bangsPlayed: Int, _ completion: @escaping FirebaseCompletion) {
        stateRef.child("players/\(playerId)/bangsPlayed").setValue(bangsPlayed) { error, _ in
            completion(result(from: error))
        }
    }
    
    func deckRemoveFirst(_ completion: @escaping FirebaseCardCompletion) {
        stateRef.child("deck").queryLimited(toFirst: 1).observeSingleEvent(of: .value) { snapshot in
            do {
                let (key, card) = try self.mapper.decodeCard(from: snapshot)
                self.stateRef.child("deck/\(key)").setValue(nil) { error, _ in
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
        stateRef.child("players/\(playerId)/hand/\(card.identifier)").setValue(true) { error, _ in
            completion(result(from: error))
        }
    }
    
    func playerRemoveHand(_ playerId: String, _ cardId: String, _ completion: @escaping FirebaseCardCompletion) {
        stateRef.child("players/\(playerId)/hand/\(cardId)").setValue(nil) { error, _ in
            do {
                let card: CardProtocol = try self.mapper.decodeCard(from: cardId)
                completion(.success(card))
            } catch {
                completion(.error(error))
            }
        }
    }
    
    func playerAddInPlay(_ playerId: String, _ card: CardProtocol, _ completion: @escaping FirebaseCompletion) {
        stateRef.child("players/\(playerId)/inPlay/\(card.identifier)").setValue(true) { error, _ in
            completion(result(from: error))
        }
    }
    
    func playerRemoveInPlay(_ playerId: String, _ cardId: String, _ completion: @escaping FirebaseCardCompletion) {
        stateRef.child("players/\(playerId)/inPlay/\(cardId)").setValue(nil) { error, _ in
            do {
                let card: CardProtocol = try self.mapper.decodeCard(from: cardId)
                completion(.success(card))
            } catch {
                completion(.error(error))
            }
        }
    }
    
    func playerSetHealth(_ playerId: String, _ health: Int, _ completion: @escaping FirebaseCompletion) {
        stateRef.child("players/\(playerId)/health").setValue(health) { error, _ in
            completion(result(from: error))
        }
    }
    
    func playerSetDamageEvent(_ playerId: String, _ event: DamageEvent, _ completion: @escaping FirebaseCompletion) {
        do {
            let value = try mapper.encodeDamageEvent(event)
            stateRef.child("players/\(playerId)/lastDamage").setValue(value) { error, _ in
                completion(result(from: error))
            }
        } catch {
            completion(.error(error))
        }
    }
    
    func setOutcome(_ outcome: GameOutcome, _ completion: @escaping FirebaseCompletion) {
        stateRef.child("outcome").setValue(outcome.rawValue) { error, _ in
            completion(result(from: error))
        }
    }
    
    func addDiscard(_ card: CardProtocol, _ completion: @escaping FirebaseCompletion) {
        stateRef.child("discardPile").childByAutoId().setValue(card.identifier) { error, _ in
            completion(result(from: error))
        }
    }
    
    func addGeneralStore(_ card: CardProtocol, _ completion: @escaping FirebaseCompletion) {
        stateRef.child("generalStore/\(card.identifier)").setValue(true) { error, _ in
            completion(result(from: error))
        }
    }
    
    func removeGeneralStore(_ cardId: String, _ completion: @escaping FirebaseCardCompletion) {
        stateRef.child("generalStore/\(cardId)").setValue(nil) { error, _ in
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
        stateRef.child("deck").queryLimited(toFirst: limit).observeSingleEvent(of: .value) { snapshot in
            do {
                let dictionary = try (snapshot.value as? [String: String]).unwrap()
                guard dictionary.keys.count <= minSize else {
                    completion(.success)
                    return
                }
                
                let deckCards = try self.mapper.decodeCards(from: snapshot)
                
                self.stateRef.child("discardPile").queryOrderedByKey().observeSingleEvent(of: .value) { snapshot in
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

private extension FirebaseGameAdapter {
    
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
            stateRef.child("deck").setValue(value)
            completion(.success)
        } catch {
            completion(.error(error))
        }
    }
    
    func setDiscardPile(_ cards: [CardProtocol], _ completion: @escaping FirebaseCompletion) {
        do {
            let value = try mapper.encodeOrderedCards(cards.reversed())
            stateRef.child("discardPile").setValue(value)
            completion(.success)
        } catch {
            completion(.error(error))
        }
    }
    
}
