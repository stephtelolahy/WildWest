//
//  MCTSAi.swift
//  WildWestEngine
//
//  Created by TELOLAHY Hugues Stéphano on 16/06/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import Foundation

public class MCTSAi: AIProtocol {
    
    private let matcher: AbilityMatcherProtocol
    
    public init(matcher: AbilityMatcherProtocol) {
        self.matcher = matcher
    }
    
    public func bestMove(among moves: [GMove], in state: StateProtocol) -> GMove {
        MCTS().findBestMove(state: state as! GState, iterations: 100)
    }
}

extension GState: MCTSState {
    public typealias Move = GMove
    
    public static var matcher: AbilityMatcherProtocol!
    
    public var status: Int {
        if let winner = self.winner {
            return winner.status
        } else {
            return MCTS.Status.inProgress
        }
    }
    
    public var turnInt: Int {
        guard let moves = Self.matcher.active(in: self),
              let move = moves.first,
              let actor = players[move.actor],
              let role = actor.role else {
            fatalError("Illegal state")
        }
        return role.status
    }
    
    public var possibleMoves: [GMove] {
        Self.matcher.active(in: self) ?? []
    }
    
    public func performMove(_ move: GMove) -> Self {
        let loop = SyncGameLoop(matcher: Self.matcher, databaseUpdater: GDatabaseUpdater())
        return loop.performMove(move, in: self) as! Self
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

public class SyncGameLoop {
    
    private let matcher: AbilityMatcherProtocol
    private let databaseUpdater: GDatabaseUpdaterProtocol
    
    public init(matcher: AbilityMatcherProtocol, databaseUpdater: GDatabaseUpdaterProtocol) {
        self.matcher = matcher
        self.databaseUpdater = databaseUpdater
    }
    
    public func performMove(_ move: GMove?, in state: StateProtocol) -> StateProtocol {
        let eventsQueue: GEventQueueProtocol = GEventQueue()
        
        if let move = move {
            eventsQueue.queue(.run(move: move))
        }
        
        let currentState = GState(state)
        
        while true {
            
            guard currentState.winner == nil else {
                break
            }
            
            guard let event = eventsQueue.pop() else {
                break
            }
            
            guard isApplicable(event, in: currentState) else {
                continue
            }
            
            databaseUpdater.execute(event, in: currentState)
            queueEffects(on: event, in: currentState, eventsQueue: eventsQueue)
            queueTriggers(on: event, in: currentState, eventsQueue: eventsQueue)
        }
        
        return currentState
    }
    
    private func isApplicable(_ event: GEvent, in state: StateProtocol) -> Bool {
        // <RULE> A move is applicable when it has effects>
        if case let .run(move) = event {
            return matcher.effects(on: move, in: state) != nil
        }
        // </RULE>
        return true
    }
    
    private func queueEffects(on event: GEvent, in state: StateProtocol, eventsQueue: GEventQueueProtocol) {
        if case let .run(move) = event,
           let events = matcher.effects(on: move, in: state) {
            events.reversed().forEach {
                eventsQueue.push($0)
            }
        }
    }
    
    private func queueTriggers(on event: GEvent, in state: StateProtocol, eventsQueue: GEventQueueProtocol) {
        if let moves = matcher.triggered(on: event, in: state) {
            moves.forEach {
                eventsQueue.queue(.run(move: $0))
            }
        }
    }
}
