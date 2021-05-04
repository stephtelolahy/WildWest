//
//  RemoteGameDatabase.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift
import Firebase
import WildWestEngine

public class RemoteGameDatabase: DatabaseProtocol {
    
    // MARK: - Dependencies
    
    private let gameRef: DatabaseReference
    private let mapper: FirebaseMapperProtocol
    
    // MARK: - Subjects
    
    public let state: BehaviorSubject<StateProtocol>
    public let event: PublishSubject<GEvent>
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    init(_ aState: StateProtocol,
         gameRef: DatabaseReference,
         mapper: FirebaseMapperProtocol) {
        self.gameRef = gameRef
        self.mapper = mapper
        state = BehaviorSubject(value: aState)
        event = PublishSubject()
        
        observeStateChanges()
        observeEventChanges()
    }
    
    // MARK: - DatabaseProtocol
    
    public func update(event aEvent: GEvent) -> Completable {
        // TODO: implement
        Completable.empty()
    }
    
    /*
    // MARK: - Flags
    
    func setTurn(_ turn: String) -> Completable {
        gameRef.child("state/turn")
            .rxSetValue({ turn })
    }
    
    func setChallenge(_ challenge: Challenge?) -> Completable {
        gameRef.child("state/challenge")
            .rxSetValue({ try self.mapper.encodeChallenge(challenge) })
    }
    
    func setOutcome(_ outcome: GameOutcome) -> Completable {
        gameRef.child("state/outcome")
            .rxSetValue({ outcome.rawValue })
    }
    
    // MARK: - Deck
    
    func deckRemoveFirst() -> Single<CardProtocol> {
        resetDeck(when: 3)
            .andThen(pullDeck())
    }
    
    func discardRemoveFirst() -> Single<CardProtocol> {
        gameRef.child("state/discardPile").queryLimited(toLast: 1)
            .rxObserveSingleEvent({ try self.mapper.decodeCard(from: $0) })
            .flatMap { key, card in
                self.gameRef.child("state/discardPile/\(key)").rxSetValue({ nil })
                    .andThen(Single.just(card))
            }
    }
    
    func addDeck(_ card: CardProtocol) -> Completable {
        gameRef.child("state/deck/-0")
            .rxSetValue({ card.identifier })
    }
    
    func addDiscard(_ card: CardProtocol) -> Completable {
        gameRef.child("state/discardPile").childByAutoId()
            .rxSetValue({ card.identifier })
    }
    
    // MARK: - General store
    
    func addGeneralStore(_ card: CardProtocol) -> Completable {
        gameRef.child("state/generalStore/\(card.identifier)")
            .rxSetValue({ true })
    }
    
    func removeGeneralStore(_ cardId: String) -> Single<CardProtocol> {
        gameRef.child("state/generalStore/\(cardId)")
            .rxSetValue({ nil })
            .andThen(Single<CardProtocol>.create({ try self.mapper.decodeCard(from: cardId) }))
    }
    
    // MARK: - Player
    
    func playerSetHealth(_ playerId: String, _ health: Int) -> Completable {
        gameRef.child("state/players/\(playerId)/health")
            .rxSetValue({ health })
    }
    
    func playerAddHand(_ playerId: String, _ card: CardProtocol) -> Completable {
        gameRef.child("state/players/\(playerId)/hand/\(card.identifier)")
            .rxSetValue({ true })
    }
    
    func playerRemoveHand(_ playerId: String, _ cardId: String) -> Single<CardProtocol> {
        gameRef.child("state/players/\(playerId)/hand/\(cardId)")
            .rxSetValue({ nil })
            .andThen(Single<CardProtocol>.create({ try self.mapper.decodeCard(from: cardId) }))
    }
    
    func playerAddInPlay(_ playerId: String, _ card: CardProtocol) -> Completable {
        gameRef.child("state/players/\(playerId)/inPlay/\(card.identifier)")
            .rxSetValue({ true })
    }
    
    func playerRemoveInPlay(_ playerId: String, _ cardId: String) -> Single<CardProtocol> {
        gameRef.child("state/players/\(playerId)/inPlay/\(cardId)")
            .rxSetValue({ nil })
            .andThen(Single<CardProtocol>.create({ try self.mapper.decodeCard(from: cardId) }))
    }
    
    func playerSetBangsPlayed(_ playerId: String, _ bangsPlayed: Int) -> Completable {
        gameRef.child("state/players/\(playerId)/bangsPlayed")
            .rxSetValue({ bangsPlayed })
    }
    
    func playerSetDamageEvent(_ playerId: String, _ event: DamageEvent) -> Completable {
        gameRef.child("state/players/\(playerId)/lastDamage")
            .rxSetValue({ try self.mapper.encodeDamageEvent(event) })
    }
    
    // MARK: - Events
    
    func setExecutedUpdate(_ update: GameUpdate) -> Completable {
        gameRef.child("executedUpdate")
            .rxSetValue({ try self.mapper.encodeUpdate(update) })
    }
    
    func setExecutedMove(_ move: GameMove) -> Completable {
        gameRef.child("executedMove")
            .rxSetValue({ try self.mapper.encodeMove(move) })
    }
    
    func setValidMoves(_ moves: [GameMove]) -> Completable {
        gameRef.child("validMoves")
            .rxSetValue({ try self.mapper.encodeMoves(moves) })
    }
     
     func resetDeck(when minSize: Int) -> Completable {
         var oldDeck: [CardProtocol] = []
         var oldDiscard: [CardProtocol] = []
         var newDeck: [CardProtocol] = []
         var newDiscard: [CardProtocol] = []
         
         let queryDeck = gameRef.child("state/deck").queryLimited(toFirst: UInt(minSize + 1))
             .rxObserveSingleEvent({ try self.mapper.decodeCards(from: $0) })
             .flatMapCompletable { cards in
                 guard cards.count <= minSize else {
                     return Completable.error(NSError(domain: "enough cards", code: 0))
                 }
                 
                 oldDeck = cards
                 return Completable.empty()
             }
         
         let queryDiscardPile = gameRef.child("state/discardPile").queryOrderedByKey()
             .rxObserveSingleEvent({ try self.mapper.decodeCards(from: $0) })
             .flatMapCompletable { cards in
                 oldDiscard = cards.reversed()
                 newDiscard = Array(oldDiscard[0..<1])
                 newDeck = (oldDeck + Array(oldDiscard[1..<oldDiscard.count])).shuffled()
                 return Completable.empty()
             }
         
         let updateDeck = self.gameRef.child("state/deck")
             .rxSetValue({ try self.mapper.encodeOrderedCards(newDeck) })
         
         let updateDiscardPile = self.gameRef.child("state/discardPile")
             .rxSetValue({ try self.mapper.encodeOrderedCards(newDiscard) })
         
         return queryDeck
             .andThen(queryDiscardPile)
             .andThen(updateDeck)
             .andThen(updateDiscardPile)
             .catchError({ _ in Completable.empty() })
     }
     
     func pullDeck() -> Single<CardProtocol> {
         gameRef.child("state/deck").queryLimited(toFirst: 1)
             .rxObserveSingleEvent({ try self.mapper.decodeCard(from: $0) })
             .flatMap { key, card in
                 self.gameRef.child("state/deck/\(key)").rxSetValue({ nil })
                     .andThen(Single.just(card))
             }
     }
     */
}

private extension RemoteGameDatabase {

    func observeStateChanges() {
        gameRef.child("state")
            .rxObserve({ try self.mapper.decodeState(from: $0) })
            .subscribe(onNext: { [weak self] aState in
                self?.state.onNext(aState)
            })
            .disposed(by: disposeBag)
    }
    
    func observeEventChanges() {
        // TODO: implement
        /*
        gameRef.child("events")
            .rxObserve({ try self.mapper.decodeUpdate(from: $0) })
            .subscribe(onNext: { [weak self] anEvent in
                self?.event.onNext(anEvent)
            })
            .disposed(by: disposeBag)
 */
    }
    
}
