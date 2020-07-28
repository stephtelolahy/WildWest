//
//  LocalGameDataBase.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 27/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable force_cast

import RxSwift

class LocalGameDataBase: GameDatabaseProtocol {
    
    private var mutableState: GameState
    private let stateSubject: BehaviorSubject<GameStateProtocol>
    private let executedMoveSubject: PublishSubject<GameMove>
    private let executedUpdateSubject: PublishSubject<GameUpdate>
    private let validMovesSubject: BehaviorSubject<[GameMove]>
    
    init(mutableState: GameState,
         stateSubject: BehaviorSubject<GameStateProtocol>,
         executedMoveSubject: PublishSubject<GameMove>,
         executedUpdateSubject: PublishSubject<GameUpdate>,
         validMovesSubject: BehaviorSubject<[GameMove]>) {
        self.mutableState = mutableState
        self.stateSubject = stateSubject
        self.executedMoveSubject = executedMoveSubject
        self.executedUpdateSubject = executedUpdateSubject
        self.validMovesSubject = validMovesSubject
    }
    
    var state: GameStateProtocol {
        mutableState
    }
    
    // MARK: - Flags
    
    func setTurn(_ turn: String) -> Completable {
        Completable.create {
            self.mutableState.turn = turn
            self.emitState()
        }
    }
    
    func setChallenge(_ challenge: Challenge?) -> Completable {
        Completable.create {
            self.mutableState.challenge = challenge
            self.emitState()
        }
    }
    
    func setOutcome(_ outcome: GameOutcome) -> Completable {
        Completable.create {
            self.mutableState.outcome = outcome
            self.emitState()
        }
    }
    
    // MARK: - Deck
    
    func deckRemoveFirst() -> Single<CardProtocol> {
        Single<CardProtocol>.create {
            self.mutableState.resetDeck(when: 2)
            let card = self.mutableState.deck.removeFirst()
            self.emitState()
            return card
        }
    }
    
    func discardRemoveFirst() -> Single<CardProtocol> {
        Single<CardProtocol>.create {
            let card = self.mutableState.discardPile.removeFirst()
            self.emitState()
            return card
        }
    }
    
    func addDiscard(_ card: CardProtocol) -> Completable {
        Completable.create {
            self.mutableState.discardPile.insert(card, at: 0)
            self.emitState()
        }
    }
    
    // MARK: - General store
    
    func addGeneralStore(_ card: CardProtocol) -> Completable {
        Completable.create {
            self.mutableState.generalStore.append(card)
            self.emitState()
        }
    }
    
    func removeGeneralStore(_ cardId: String) -> Single<CardProtocol> {
        Single<CardProtocol>.create {
            let card = self.mutableState.generalStore.removeFirst(where: { $0.identifier == cardId })!
            self.emitState()
            return card
        }
    }
    
    // MARK: - Player
    
    func playerSetHealth(_ playerId: String, _ health: Int) -> Completable {
        Completable.create {
            self.mutablePlayer(playerId).health = health
            self.emitState()
        }
    }
    
    func playerAddHand(_ playerId: String, _ card: CardProtocol) -> Completable {
        Completable.create {
            self.mutablePlayer(playerId).hand.append(card)
            self.emitState()
        }
    }
    
    func playerRemoveHand(_ playerId: String, _ cardId: String) -> Single<CardProtocol> {
        Single<CardProtocol>.create {
            let card = self.mutablePlayer(playerId).hand.removeFirst(where: { $0.identifier == cardId })!
            self.emitState()
            return card
        }
    }
    
    func playerAddInPlay(_ playerId: String, _ card: CardProtocol) -> Completable {
        Completable.create {
            self.mutablePlayer(playerId).inPlay.append(card)
            self.emitState()
        }
    }
    
    func playerRemoveInPlay(_ playerId: String, _ cardId: String) -> Single<CardProtocol> {
        Single<CardProtocol>.create {
            let card = self.mutablePlayer(playerId).inPlay.removeFirst(where: { $0.identifier == cardId })!
            self.emitState()
            return card
        }
    }
    
    func playerSetBangsPlayed(_ playerId: String, _ bangsPlayed: Int) -> Completable {
        Completable.create {
            self.mutablePlayer(playerId).bangsPlayed = bangsPlayed
            self.emitState()
        }
    }
    
    func playerSetDamageEvent(_ playerId: String, _ event: DamageEvent) -> Completable {
        Completable.create {
            self.mutablePlayer(playerId).lastDamage = event
            self.emitState()
        }
    }
    
    // MARK: - Events
    
    func setExecutedUpdate(_ update: GameUpdate) -> Completable {
        Completable.create {
            self.executedUpdateSubject.onNext(update)
        }
    }
    
    func setExecutedMove(_ move: GameMove) -> Completable {
        Completable.create {
            self.executedMoveSubject.onNext(move)
        }
    }
    
    func setValidMoves(_ moves: [GameMove]) -> Completable {
        Completable.create {
            self.validMovesSubject.onNext(moves)
        }
    }
}

private extension LocalGameDataBase {
    
    func mutablePlayer(_ playerId: String) -> Player {
        mutableState.allPlayers.first(where: { $0.identifier == playerId }) as! Player
    }
    
    func emitState() {
        stateSubject.onNext(mutableState)
    }
}

private extension GameState {
    
    func resetDeck(when minSize: Int) {
        guard deck.count <= minSize else {
            return
        }
        
        let cards = discardPile
        deck.append(contentsOf: Array(cards[1..<cards.count]).shuffled())
        discardPile = Array(cards[0..<1])
    }
}
