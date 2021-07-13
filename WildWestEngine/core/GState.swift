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
        self.winner = winner
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
                  history: state.history,
                  winner: state.winner)
    }
    
    // MARK: - StateComputedProtocol
    
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
        
        distance -= scope(for: player)
        
        distance += mustang(for: other)
        
        return distance
    }
}

private extension StateProtocol {
    
    func scope(for player: String) -> Int {
        activeInPlayCards(for: player).compactMap { $0.attributes[.scope] as? Int }.reduce(0, +)
    }
    
    func mustang(for player: String) -> Int {
        activeInPlayCards(for: player).compactMap { $0.attributes[.mustang] as? Int }.reduce(0, +)
    }
    
    func activeInPlayCards(for player: String) -> [CardProtocol] {
        guard let playerObject = players[player] else {
            return []
        }
        
        if turn != player,
           players[turn]?.attributes[.silentInPlay] != nil {
            return [playerObject]
        }
        
        return [playerObject] + playerObject.inPlay
    }
}

private extension GPlayer {
    
    convenience init(_ player: PlayerProtocol) {
        self.init(identifier: player.identifier,
                  name: player.name,
                  desc: player.desc,
                  attributes: player.attributes,
                  abilities: player.abilities,
                  role: player.role,
                  health: player.health,
                  hand: player.hand,
                  inPlay: player.inPlay)
    }
}

private extension GHit {
    
    init(_ hit: HitProtocol) {
        self.init(player: hit.player,
                  name: hit.name,
                  abilities: hit.abilities,
                  offender: hit.offender,
                  cancelable: hit.cancelable,
                  target: hit.target)
    }
}
