//
//  MediaEventMatcher.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 26/11/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import CardGameEngine

protocol MediaEventMatcherProtocol {
    func emoji(on event: GEvent) -> String?
    func sfx(on event: GEvent) -> String?
}

struct EventMedia: Decodable {
    let emoji: String
    let sfx: String?
    let playReqs: [[String: String]]
}

class MediaEventMatcher: MediaEventMatcherProtocol {
    
    private let mediaArray: [EventMedia]
    
    init(mediaArray: [EventMedia]) {
        self.mediaArray = mediaArray
    }
    
    func emoji(on event: GEvent) -> String? {
        guard let media = media(matching: event) else {
            return nil
        }
        return media.emoji
    }
    
    func sfx(on event: GEvent) -> String? {
        guard let media = media(matching: event) else {
            return nil
        }
        return media.sfx
    }
}

private extension MediaEventMatcher {
    
    func media(matching event: GEvent) -> EventMedia? {
        let destructed = destructuring(event)
        let matching = mediaArray.filter { $0.playReqs.contains(where: { destructed.matches($0) }) }
        assert(matching.count < 2, "Illegal state")
        return matching.first
    }
}

private extension MediaEventMatcher {
    
    func destructuring(_ event: GEvent) -> [String: String] {
        switch event {
        case let .play(move):
            return ["event": event.hashValue, 
                    "ability": move.name]
            
        default:
            return ["event": event.hashValue]
        }
    }
}

private extension Dictionary where Key == String, Value == String {
    func matches(_ requirements: [String: String]) -> Bool {
        requirements.allSatisfy { key, value -> Bool in
            self[key] == value
        }
    }
} 
