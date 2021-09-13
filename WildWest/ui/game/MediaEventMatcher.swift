//
//  MediaEventMatcher.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 26/11/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import WildWestEngine

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
        let destructed = event.destructuring()
        var matchedMedia: EventMedia?
        var matchedCriteria = 0
        
        for media in mediaArray {
            for playReq in media.playReqs {
                if destructed.matches(playReq), 
                   playReq.count > matchedCriteria {
                    matchedMedia = media
                    matchedCriteria = playReq.count
                }
            }
        }
        
        return matchedMedia
    }
}

private extension Dictionary where Key == String, Value == String {
    func matches(_ requirements: [String: String]) -> Bool {
        requirements.allSatisfy { key, value -> Bool in
            self[key] == value
        }
    }
} 

private extension GEvent {
    
    var name: String {
        var string = String(describing: self)
        if let eventName = string.components(separatedBy: "(").first {
            string = eventName
        }
        return string
    }
    
    func destructuring() -> [String: String] {
        switch self {
        case let .run(move):
            return ["event": name,
                    "ability": move.ability]
            
        case let .addHit(hits):
            return ["event": name,
                    "ability": hits[0].name]
            
        default:
            return ["event": name]
        }
    }
}
