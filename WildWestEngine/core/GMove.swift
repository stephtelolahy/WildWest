//
//  GMove.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 26/09/2020.
//

public struct GMove: Equatable {
    public let ability: String
    public let actor: String
    public let card: PlayCard?
    public let args: [PlayArg: [String]]
    
    public init(_ ability: String, actor: String, card: PlayCard? = nil, args: [PlayArg: [String]] = [:]) {
        self.ability = ability
        self.actor = actor
        self.card = card
        self.args = args
    }
}

public enum PlayCard: Equatable {
    case hand(String)
    case inPlay(String)
}

public enum PlayArg: String, Equatable {
    case target
    case requiredInPlay
    case requiredStore
    case requiredHand
    case requiredDeck
}
