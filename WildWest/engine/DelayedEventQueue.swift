//
//  DelayedEventQueue.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 15/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

class DelayedEventQueue: EventQueueProtocol {
    
    private let observable: PublishSubject<GameEvent>
    private var queue: [GameEvent]
    private let delay: TimeInterval
    private var running: Bool
    
    init(delay: TimeInterval) {
        self.delay = delay
        queue = []
        running = false
        observable = PublishSubject()
    }
    
    var isEmpty: Bool {
        queue.isEmpty
    }
    
    func pop() -> Observable<GameEvent> {
        observable
    }
    
    func push(_ element: GameEvent) {
        queue.insert(element, at: 0)
        runIfNeeded()
    }
    
    func add(_ element: GameEvent) {
        assert(!queue.contains(element), "Duplicate events")
        queue.append(element)
        runIfNeeded()
    }
    
    private func runIfNeeded() {
        guard !running else {
            return
        }
        running = true
        
        // emmit immediately if awakening
        observable.onNext(queue.remove(at: 0))
        
        // schedule emit remaining elements after some delay
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: delay, repeats: true) { [weak self] timer in
                guard let self = self else {
                    return
                }
                
                guard !self.queue.isEmpty else {
                    timer.invalidate()
                    self.running = false
                    return
                }
                
                self.observable.onNext(self.queue.remove(at: 0))
            }
        } else {
            while !queue.isEmpty {
                observable.onNext(queue.remove(at: 0))
            }
            running = false
        }
    }
}
