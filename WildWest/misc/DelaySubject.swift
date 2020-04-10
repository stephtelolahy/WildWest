//
//  DelaySubject.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 27/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Foundation
import RxSwift

/// A king of PublishSubject emmiting value every fixed interval
open class DelaySubject<Element> where Element: Any {
    
    let observable: PublishSubject<Element>
    var queue: [Element]
    
    private let delay: TimeInterval
    private var running: Bool
    
    init(delay: TimeInterval) {
        self.delay = delay
        self.queue = []
        self.running = false
        self.observable = PublishSubject()
    }
    
    func onNext(_ value: Element) {
        queue.append(value)
        
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
