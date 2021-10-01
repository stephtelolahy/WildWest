//
//  GEvent.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 26/09/2020.
//

public enum GEvent: Equatable {
    
    // MARK: - Card changes
    
    case play(player: String, card: String)
    case equip(player: String, card: String)
    case handicap(player: String, card: String, other: String)
    
    case drawDeck(player: String)
    case drawDeckFlipping(player: String)
    case drawDeckChoosing(player: String, card: String)
    case drawHand(player: String, other: String, card: String)
    case drawInPlay(player: String, other: String, card: String)
    case drawStore(player: String, card: String)
    case drawDiscard(player: String)
    
    case discardHand(player: String, card: String)
    case discardInPlay(player: String, card: String)
    case passInPlay(player: String, card: String, other: String)
    
    case deckToStore // drawDeckThenPutInStore
    case flipDeck    // drawDeckFlippingThenDiscard
    
    // MARK: - Flag changes
    
    case setTurn(player: String)
    case setPhase(value: Int)
    
    case gainHealth(player: String)
    case looseHealth(player: String, offender: String)
    case eliminate(player: String, offender: String)
    
    case addHit(hit: GHit) // setHit
    case removeHit(player: String)
    case decrementHitCancelable
    
    case gameover(winner: Role)
    
    // MARK: - Engine events
    
    case activate(moves: [GMove])
    case run(move: GMove)
    case emptyQueue // idle
}
