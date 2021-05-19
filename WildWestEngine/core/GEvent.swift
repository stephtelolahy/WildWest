//
//  GEvent.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 26/09/2020.
//

public enum GEvent: Equatable {
    
    case activate(moves: [GMove])
    case run(move: GMove)
    
    case play(player: String, card: String)
    case equip(player: String, card: String)
    case handicap(player: String, card: String, other: String)
    
    case setTurn(player: String)
    case setPhase(value: Int)
    
    case gainHealth(player: String)
    case looseHealth(player: String, offender: String)
    case eliminate(player: String, offender: String)
    
    case drawDeck(player: String)
    case drawHand(player: String, other: String, card: String)
    case drawInPlay(player: String, other: String, card: String)
    case drawStore(player: String, card: String)
    case drawDiscard(player: String)
    
    case discardHand(player: String, card: String)
    case discardInPlay(player: String, card: String)
    case passInPlay(player: String, card: String, other: String)
    
    case deckToStore
    case storeToDeck(card: String)
    
    case revealDeck
    case revealHand(player: String, card: String)
    
    case addHit(player: String, name: String, abilities: [String], cancelable: Int, offender: String)
    case removeHit(player: String)
    case cancelHit(player: String)
    
    case gameover(winner: Role)
    case emptyQueue
}
