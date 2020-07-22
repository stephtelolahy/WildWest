//
//  GameDatabaseProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 10/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

protocol GameDatabaseProtocol {
    
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
    
    // Events
    func setExecutedUpdate(_ update: GameUpdate) -> Completable
    func setExecutedMove(_ move: GameMove) -> Completable
    func setValidMoves(_ moves: [GameMove]) -> Completable
}
