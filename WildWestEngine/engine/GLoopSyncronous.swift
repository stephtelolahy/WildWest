//
//  GLoopSyncronous.swift
//  WildWestEngine
//
//  Created by TELOLAHY Hugues Stéphano on 19/06/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

public protocol GLoopSyncronousProtocol {
    func run(_ move: GMove?, in state: StateProtocol) -> StateProtocol
}

public class GLoopSyncronous: GLoopSyncronousProtocol {
    
    private let rules: GameRulesProtocol
    private let databaseUpdater: GDatabaseUpdaterProtocol
    
    public init(rules: GameRulesProtocol, databaseUpdater: GDatabaseUpdaterProtocol) {
        self.rules = rules
        self.databaseUpdater = databaseUpdater
    }
    
    public func run(_ move: GMove?, in state: StateProtocol) -> StateProtocol {
        let eventsQueue: GEventQueueProtocol = GEventQueue()
        
        if let move = move {
            eventsQueue.queue(.run(move: move))
        }
        
        let currentState = GState.copy(state)
        
        while true {
            
            if let winner = rules.winner(in: currentState) {
                databaseUpdater.execute(.gameover(winner: winner), in: currentState)
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
            return rules.effects(on: move, in: state) != nil
        }
        // </RULE>
        return true
    }
    
    private func queueEffects(on event: GEvent, in state: StateProtocol, eventsQueue: GEventQueueProtocol) {
        if case let .run(move) = event,
           let events = rules.effects(on: move, in: state) {
            events.reversed().forEach {
                eventsQueue.push($0)
            }
        }
    }
    
    private func queueTriggers(on event: GEvent, in state: StateProtocol, eventsQueue: GEventQueueProtocol) {
        if let moves = rules.triggered(on: event, in: state) {
            moves.forEach {
                eventsQueue.queue(.run(move: $0))
            }
        }
    }
}
