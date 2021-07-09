//
//  State.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 26/09/2020.
//

public protocol StateStoredProtocol {
    var players: [String: PlayerProtocol] { get }
    var initialOrder: [String] { get }  // Initial player order
    var playOrder: [String] { get }     // the turn order
    var turn: String { get }            // the only player that can normally make active moves during the turn.
    var phase: Int { get }              // current phase within current turn
    var deck: [CardProtocol] { get }    // stack of cards
    var discard: [CardProtocol] { get } // discard pile
    var store: [CardProtocol] { get }   // choosable cards collection, may be hidden to some players
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

public protocol BaseCardProtocol {
    var name: String { get }
    var desc: String { get }
    var abilities: [String: Int] { get }
    var attributes: CardAttributesProtocol { get }
}

public protocol CardAttributesProtocol {
    var bullets: Int? { get }
    var mustang: Int? { get }
}

public protocol PlayerStoredProtocol: BaseCardProtocol {
    var identifier: String { get }
    var role: Role? { get }
    var maxHealth: Int { get }
    var health: Int { get }
    var hand: [CardProtocol] { get }
    var inPlay: [CardProtocol] { get }
}

public protocol PlayerComputedProtocol {
    var weapon: Int { get }
    var scope: Int { get }
    var mustang: Int { get }
    var bangsPerTurn: Int { get }
    var bangsCancelable: Int { get }
    var flippedCards: Int { get }
    var handLimit: Int { get }
}

public protocol PlayerProtocol: PlayerStoredProtocol, PlayerComputedProtocol {
}

public protocol CardProtocol: BaseCardProtocol {
    var identifier: String { get }
    var type: CardType { get }
    var suit: String { get }
    var value: String { get }
}

public enum Role: String, CaseIterable {
    case sheriff
    case outlaw
    case renegade
    case deputy
}
