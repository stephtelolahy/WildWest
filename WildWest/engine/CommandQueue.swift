//
//  CommandQueue.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 11/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

class DelayedCommandQueue: CommandQueueProtocol {
    
    private let observable: PublishSubject<GameMove>
    private var queue: [GameMove]
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
    
    func pull() -> Observable<GameMove> {
        observable
    }
    
    func add(_ element: GameMove) {
        
        queue.append(element)
        
        guard !running else {
            return
        }
        running = true
        
        observable.onNext(queue.remove(at: 0))
        
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
