//
//  GState.swift
//  CardGameEngine
//
//  Created by Hugues Stéphano TELOLAHY on 10/24/20.
//

public class GState: StateProtocol {
    
    // MARK: Properties
    
    public let players: [String: PlayerProtocol]
    public let initialOrder: [String]
    public var playOrder: [String]
    public var turn: String
    public var phase: Int
    public var deck: [CardProtocol]
    public var discard: [CardProtocol]
    public var store: [CardProtocol]
    public var hits: [HitProtocol]
    public var played: [String]
    public var history: [GMove]
    public var winner: Role?
    
    // MARK: Init
    
    public init(players: [String: PlayerProtocol],
                initialOrder: [String],
                playOrder: [String],
                turn: String,
                phase: Int,
                deck: [CardProtocol],
                discard: [CardProtocol],
                store: [CardProtocol],
                hits: [HitProtocol],
                played: [String],
                history: [GMove],
                winner: Role?) {
        self.players = players
        self.initialOrder = initialOrder
        self.playOrder = playOrder
        self.turn = turn
        self.phase = phase
        self.deck = deck
        self.discard = discard
        self.store = store
        self.hits = hits
        self.played = played
        self.history = history
        self.winner = winner
    }
}
