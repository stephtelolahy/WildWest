//
//  MCTSAi.swift
//  WildWestEngine
//
//  Created by TELOLAHY Hugues Stéphano on 16/06/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//
// swiftlint:disable force_cast

import Foundation
import Resolver

public class MCTSAi: AIProtocol {
    
    private let matcher: AbilityMatcherProtocol
    
    public init(matcher: AbilityMatcherProtocol) {
        self.matcher = matcher
    }
    
    public func bestMove(among moves: [GMove], in state: StateProtocol) -> GMove {
        MCTS().findBestMove(state: state as! GState)
    }
}

extension GState: MCTSState {
    public typealias Move = GMove
    
    public static var matcher: AbilityMatcherProtocol = Resolver.resolve()
    
    public var status: Int {
        if let winner = self.winner {
            return winner.status
        } else {
            return MCTS.Status.inProgress
        }
    }
    
    public var player: Int {
        guard let moves = Self.matcher.active(in: self),
              let move = moves.first,
              let actor = players[move.actor],
              let role = actor.role else {
            fatalError("Illegal state")
        }
        return role.status
    }
    
    public var possibleMoves: [GMove] {
        let moves = Self.matcher.active(in: self) ?? []
        
        // <HACK: avoid looseHealth and endTurn if possible>
        let preferredMoves = moves.filter { $0.ability != "looseHealth" && $0.ability != "endTurn" }
        if !preferredMoves.isEmpty {
            return preferredMoves
        } else {
            return moves
        }
    }
    
    public func performMove(_ move: GMove) -> Self {
        let loop = GLoopSyncronous(matcher: Self.matcher, databaseUpdater: GDatabaseUpdater())
        return loop.run(move, in: self) as! Self
    }
}

private extension Role {
    var status: Int {
        switch self {
        case .sheriff,
             .deputy:
            return 1
            
        case .outlaw:
            return 2
            
        case .renegade:
            return 3
        }
    }
}
