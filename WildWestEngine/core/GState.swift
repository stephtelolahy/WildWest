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
    public var storeView: String?
    public var hits: [HitProtocol]
    public var played: [String]
    
    // MARK: Init
    
    public init(players: [String: PlayerProtocol],
                initialOrder: [String],
                playOrder: [String],
                turn: String,
                phase: Int,
                deck: [CardProtocol],
                discard: [CardProtocol],
                store: [CardProtocol],
                storeView: String?,
                hits: [HitProtocol],
                played: [String]) {
        self.players = players.mapValues { GPlayer($0) }
        self.initialOrder = initialOrder
        self.playOrder = playOrder
        self.turn = turn
        self.phase = phase
        self.deck = deck
        self.discard = discard
        self.store = store
        self.storeView = storeView
        self.hits = hits.map { GHit($0) }
        self.played = played
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
                  storeView: state.storeView,
                  hits: state.hits,
                  played: state.played)
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
