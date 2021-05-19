//
//  GEventQueue.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 29/10/2020.
//

public protocol GEventQueueProtocol {
    func queue(_ event: GEvent)
    func push(_ event: GEvent)
    func pop() -> GEvent?
}

public class GEventQueue: GEventQueueProtocol {
    
    private var events: [GEvent]
    private var shouldEmitEmpty: Bool
    
    public init() {
        self.events = []
        self.shouldEmitEmpty = true
    }
    
    public func queue(_ event: GEvent) {
        events.append(event)
        shouldEmitEmpty = true
    }
    
    public func push(_ event: GEvent) {
        events.insert(event, at: 0)
        shouldEmitEmpty = true
    }
    
    public func pop() -> GEvent? {
        guard !events.isEmpty else {
            if shouldEmitEmpty {
                shouldEmitEmpty = false
                return .emptyQueue
            } else {
                return nil
            }
        }
        return events.remove(at: 0)
    }
}
