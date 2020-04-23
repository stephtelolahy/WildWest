//
//  RemoteDatabase.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Firebase
import RxSwift

class RemoteDatabase: GameDatabaseProtocol {
    
    let stateSubject: BehaviorSubject<GameStateProtocol>
    
    init(state: GameStateProtocol) {
        stateSubject = BehaviorSubject(value: state)
        Database.database().addGame(state)
    }
    
    func setTurn(_ turn: String) {
        fatalError("Undefined")
    }
    
    func setChallenge(_ challenge: Challenge?) {
        fatalError("Undefined")
    }
    
    func setOutcome(_ outcome: GameOutcome) {
        fatalError("Undefined")
    }
    
    func deckRemoveFirst() -> CardProtocol {
        fatalError("Undefined")
    }
    
    func addDiscard(_ card: CardProtocol) {
        fatalError("Undefined")
    }
    
    func addGeneralStore(_ card: CardProtocol) {
        fatalError("Undefined")
    }
    
    func removeGeneralStore(_ cardId: String) -> CardProtocol? {
        fatalError("Undefined")
    }
    
    func playerSetHealth(_ playerId: String, _ health: Int) {
        fatalError("Undefined")
    }
    
    func playerAddHand(_ playerId: String, _ card: CardProtocol) {
        fatalError("Undefined")
    }
    
    func playerRemoveHand(_ playerId: String, _ cardId: String) -> CardProtocol? {
        fatalError("Undefined")
    }
    
    func playerAddInPlay(_ playerId: String, _ card: CardProtocol) {
        fatalError("Undefined")
    }
    
    func playerRemoveInPlay(_ playerId: String, _ cardId: String) -> CardProtocol? {
        fatalError("Undefined")
    }
    
    func playerSetBangsPlayed(_ playerId: String, _ bangsPlayed: Int) {
        fatalError("Undefined")
    }
    
    func playerSetDamageEvent(_ playerId: String, _ event: DamageEvent) {
        fatalError("Undefined")
    }
}
