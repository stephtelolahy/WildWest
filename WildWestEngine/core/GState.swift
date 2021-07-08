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
                history: [GMove]) {
        self.players = players.mapValues { GPlayer($0) }
        self.initialOrder = initialOrder
        self.playOrder = playOrder
        self.turn = turn
        self.phase = phase
        self.deck = deck
        self.discard = discard
        self.store = store
        self.hits = hits.map { GHit($0) }
        self.played = played
        self.history = history
    }
    
    public convenience init(_ state: StateProtocol) {
        self.init(players: state.players,
                  initialOrder: state.initialOrder,
                  playOrder: state.playOrder,
                  turn: state.turn,
                  phase: state.phase,
                  deck: state.deck,
                  discard: state.discard,
                  store: state.store,
                  hits: state.hits,
                  played: state.played,
                  history: state.history)
    }
    
    // MARK: - StateComputedProtocol
    
    public var winner: Role? {
        let remainingRoles = playOrder.map { players[$0]!.role }
        
        let noSheriff = !remainingRoles.contains(.sheriff)
        if noSheriff {
            let lastIsRenegade = remainingRoles.count == 1 && remainingRoles[0] == .renegade
            if lastIsRenegade {
                return .renegade
            } else {
                return .outlaw
            }
        }
        
        let noOutlawsAndRenegates = !remainingRoles.contains(where: { $0 == .outlaw || $0 == .renegade })
        if noOutlawsAndRenegates {
            return .sheriff
        }
        
        return nil
    }
    
    public func distance(from player: String, to other: String) -> Int {
        guard let pIndex = playOrder.firstIndex(of: player),
              let oIndex = playOrder.firstIndex(of: other),
              pIndex != oIndex else {
            return 0
        }
        
        let count = playOrder.count
        let rightDistance = (oIndex > pIndex) ? (oIndex - pIndex) : (oIndex + count - pIndex)
        let leftDistance = (pIndex > oIndex) ? (pIndex - oIndex) : (pIndex + count - oIndex)
        var distance = min(rightDistance, leftDistance)
        
        distance -= players[player]!.scope
        
        distance += players[other]!.mustang
        
        return distance
    }
}
