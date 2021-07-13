//
//  State.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 26/09/2020.
//

public protocol StateStoredProtocol {
    var players: [String: PlayerProtocol] { get }
    var initialOrder: [String] { get }  // initial players order
    var playOrder: [String] { get }     // active players order
    var turn: String { get }            // current player
    var phase: Int { get }              // current phase
    var deck: [CardProtocol] { get }    // stack of cards
    var discard: [CardProtocol] { get } // discard pile
    var store: [CardProtocol] { get }   // choosable cards
    var hits: [HitProtocol] { get }     // blocking challenge to be resolved before continuing turn
    var played: [String] { get }        // played abilities during current turn
    var history: [GMove] { get }        // move history
}

public protocol StateComputedProtocol {
    var winner: Role? { get }
    
    func distance(from player: String, to other: String) -> Int
}

public protocol StateProtocol: StateStoredProtocol, StateComputedProtocol {
}

public protocol HitProtocol {
    var player: String { get }
    var name: String { get }
    var abilities: [String] { get }
    var offender: String { get }
    var cancelable: Int { get }
    var target: String? { get }
}

public protocol CardProtocol {
    var identifier: String { get }
    var name: String { get }
    var desc: String { get }
    var type: CardType { get }
    var attributes: [CardAttributeKey: Any] { get }
    var abilities: Set<String> { get }
    var suit: String { get }
    var value: String { get }
}

public protocol PlayerProtocol: CardProtocol {
    var role: Role? { get }
    var health: Int { get }
    var hand: [CardProtocol] { get }
    var inPlay: [CardProtocol] { get }
}

public enum Role: String, CaseIterable {
    case sheriff
    case outlaw
    case renegade
    case deputy
}

public enum CardAttributeKey: String {
    case bullets        // max health
    case mustang        // increment distance from others
    case scope          // decrement distance to others
    case weapon         // gun range, default: 1
    case flippedCards   // number of flipped cards on a draw, default: 1
    case bangsCancelable// number of 'missed' required to cancel your bang, default: 1
    case bangsPerTurn   // number of bangs per turn, default: 1
    case handLimit      // max number of cards at end of turn, default: health
    case silentCard     // prevent other players to play a card matching given regex
    case silentAbility  // disable self ability matching given name
    case playAs         // can play card matching [regex] with ability [name]
    case silentInPlay   // during your turn, cards in play in front of other players have no effect
}
