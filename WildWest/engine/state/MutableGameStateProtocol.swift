//
//  MutableGameStateProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 10/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

protocol MutableGameStateProtocol {
    func setTurn(_ turn: String)
    func setChallenge(_ challenge: Challenge?)
    func setBangsPlayed(_ bangsPlayed: Int)
    func addCommand(_ command: ActionProtocol)
    func setActions(_ actions: [ActionProtocol])
    func setOutcome(_ outcome: GameOutcome)
    func removePlayer(_ playerId: String) -> PlayerProtocol?
    func addEliminated(_ player: PlayerProtocol)
    
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
    func playerRemoveAllHand(_ playerId: String) -> [CardProtocol]
    func playerRemoveAllInPlay(_ playerId: String) -> [CardProtocol]
    
}
