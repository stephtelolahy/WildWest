//
//  GTimer.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 30/10/2020.
//

public protocol GTimerProtocol {
    func wait(_ event: GEvent, completion: @escaping () -> Void)
}

public protocol EventDurationProtocol {
    func waitDuration(_ event: GEvent) -> TimeInterval
}

public class GTimer: GTimerProtocol {
    
    private let matcher: EventDurationProtocol
    
    public init(matcher: EventDurationProtocol) {
        self.matcher = matcher
    }
    
    public func wait(_ event: GEvent, completion: @escaping () -> Void) {
        let waitDelay = matcher.waitDuration(event)
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: waitDelay, repeats: false) { timer in
                timer.invalidate()
                completion()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + waitDelay) {
                completion()
            }
        }
    }
}
