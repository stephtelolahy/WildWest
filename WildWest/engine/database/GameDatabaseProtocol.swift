//
//  GameDatabaseProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 10/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

protocol GameDatabaseProtocol {
    
    // Observable
    var stateSubject: BehaviorSubject<GameStateProtocol> { get }
    
    // Flags
    func setTurn(_ turn: String) -> Completable
    func setChallenge(_ challenge: Challenge?) -> Completable
    func setOutcome(_ outcome: GameOutcome) -> Completable
    
    /// Deck
    func deckRemoveFirst() -> Single<CardProtocol>
    func addDiscard(_ card: CardProtocol) -> Completable
    func addGeneralStore(_ card: CardProtocol) -> Completable
    func removeGeneralStore(_ cardId: String) -> Single<CardProtocol>
    
    /// Player
    func playerSetHealth(_ playerId: String, _ health: Int) -> Completable
    func playerAddHand(_ playerId: String, _ card: CardProtocol) -> Completable
    func playerRemoveHand(_ playerId: String, _ cardId: String) -> Single<CardProtocol>
    func playerAddInPlay(_ playerId: String, _ card: CardProtocol) -> Completable
    func playerRemoveInPlay(_ playerId: String, _ cardId: String) -> Single<CardProtocol>
    func playerSetBangsPlayed(_ playerId: String, _ bangsPlayed: Int) -> Completable
    func playerSetDamageEvent(_ playerId: String, _ event: DamageEvent) -> Completable
}
