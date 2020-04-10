//
//  GameDatabaseProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 10/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

/// Accessor to state
protocol GameDatabaseProtocol {
    
    var state: GameStateProtocol { get }
    
    // Flags
    func setTurn(_ turn: String)
    func setChallenge(_ challenge: Challenge?)
    func setOutcome(_ outcome: GameOutcome)
    
    /// Deck
    func deckRemoveFirst() -> CardProtocol
    func addDiscard(_ card: CardProtocol)
    func addGeneralStore(_ card: CardProtocol)
    func removeGeneralStore(_ cardId: String) -> CardProtocol?
    
    /// Player
    func playerSetHealth(_ playerId: String, _ health: Int)
    func playerAddHand(_ playerId: String, _ card: CardProtocol)
    func playerRemoveHand(_ playerId: String, _ cardId: String) -> CardProtocol?
    func playerAddInPlay(_ playerId: String, _ card: CardProtocol)
    func playerRemoveInPlay(_ playerId: String, _ cardId: String) -> CardProtocol?
    func playerSetBangsPlayed(_ playerId: String, _ bangsPlayed: Int)
    func playerSetDamageEvent(_ playerId: String, _ event: DamageEvent)
}
