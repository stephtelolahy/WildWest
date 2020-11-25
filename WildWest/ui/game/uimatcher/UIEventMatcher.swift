//
//  UIEventMatcher.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/11/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import CardGameEngine
import Resolver

protocol UIEventMatcherProtocol: EventMatcherProtocol {
    func animation(on event: GEvent) -> EventAnimation?
    func sfx(on event: GEvent) -> String?
    func emoji(_ event: GEvent) -> String?
}

struct EventAnimation {
    let type: EventAnimationType
    let duration: TimeInterval
}

enum EventAnimationType {
    case move(card: String?, source: CardArea, target: CardArea)
    case reveal(card: String?, source: CardArea, target: CardArea)
    case dummy
}

enum CardArea: Hashable {
    case deck
    case discard
    case store
    case hand(String)
    case inPlay(String)
}

enum StateCard {
    static let deck = "deck"
    static let discard = "discard"
}

class UIEventMatcher: UIEventMatcherProtocol {
    
    static let preferences: UserPreferencesProtocol = Resolver.resolve()
    
    func waitDuration(_ event: GEvent) -> Double {
        guard let anim = animation(on: event) else {
            return 0
        }
        
        return anim.duration
    }
    
    func animation(on event: GEvent) -> EventAnimation? {
        guard let gfx = Self.gfx[event.hashValue] else {
            print("⚠️ No animation matching \(event)")
            return nil
        }
        
        return gfx.animateFunc(event)
    }
    
    func sfx(on event: GEvent) -> String? {
        Self.sfx[event.hashValue]
    }
    
    func emoji(_ event: GEvent) -> String? {
        Self.emoji[event.hashValue]
    }
}

private typealias EventAnimateFunc = (GEvent) -> EventAnimation

private struct EventDesc {
    let id: String
    let animateFunc: EventAnimateFunc
}

private extension UIEventMatcher {
    
    static let gfx: [String: EventDesc] = [
        play(),
        setTurn(),
        setPhase(),
        gainHealth(),
        looseHealth(),
        eliminate(),
        addHit(),
        drawDeck(),
        drawDiscard(),
        discardHand(),
        putInPlay(),
        revealHand(),
        discardInPlay(),
        drawHand(),
        drawInPlay(),
        putInPlayOther(),
        passInPlayOther(),
        revealDeck(),
        deckToStore(),
        storeToDeck(),
        drawStore()
    ]
    .toDictionary(with: { $0.id })
    
    static func play() -> EventDesc {
        EventDesc(id: "play") { _ in
            EventAnimation(type: .dummy, duration: preferences.updateDelay)
        }
    }
    
    static func setTurn() -> EventDesc {
        EventDesc(id: "setTurn") { _ in
            EventAnimation(type: .dummy, duration: preferences.updateDelay)
        }
    }
    
    static func setPhase() -> EventDesc {
        EventDesc(id: "setPhase") { _ in
            EventAnimation(type: .dummy, duration: preferences.updateDelay)
        }
    }
    
    static func gainHealth() -> EventDesc {
        EventDesc(id: "gainHealth") { _ in
            EventAnimation(type: .dummy, duration: preferences.updateDelay)
        }
    }
    
    static func looseHealth() -> EventDesc {
        EventDesc(id: "looseHealth") { _ in
            EventAnimation(type: .dummy, duration: preferences.updateDelay)
        }
    }
    
    static func eliminate() -> EventDesc {
        EventDesc(id: "eliminate") { _ in
            EventAnimation(type: .dummy, duration: preferences.updateDelay)
        }
    }
    
    static func addHit() -> EventDesc {
        EventDesc(id: "addHit") { _ in
            EventAnimation(type: .dummy, duration: preferences.updateDelay)
        }
    }
    
    static func drawDeck() -> EventDesc {
        EventDesc(id: "drawDeck") { event in
            guard case let .drawDeck(player) = event else {
                fatalError("Invalid event")
            }
            
            return EventAnimation(type: .move(card: nil, source: .deck, target: .hand(player)),
                                  duration: preferences.updateDelay)
        }
    }
    
    static func drawDiscard() -> EventDesc {
        EventDesc(id: "drawDiscard") { event in
            guard case let .drawDiscard(player) = event else {
                fatalError("Invalid event")
            }
            return EventAnimation(type: .move(card: StateCard.discard, source: .discard, target: .hand(player)),
                                  duration: preferences.updateDelay)
        }
    }
    
    static func discardHand() -> EventDesc {
        EventDesc(id: "discardHand") { event in
            guard case let .discardHand(player, card) = event else {
                fatalError("Invalid event")
            }
            return EventAnimation(type: .move(card: card, source: .hand(player), target: .discard),
                                  duration: preferences.updateDelay)
        }
    }
    
    static func putInPlay() -> EventDesc {
        EventDesc(id: "putInPlay") { event in
            guard case let .putInPlay(player, card) = event else {
                fatalError("Invalid event")
            }
            return EventAnimation(type: .move(card: card, source: .hand(player), target: .inPlay(player)),
                                  duration: preferences.updateDelay)
        }
    }
    
    static func revealHand() -> EventDesc {
        EventDesc(id: "revealHand") { event in
            guard case let .revealHand(player, card) = event else {
                fatalError("Invalid event")
            }
            return EventAnimation(type: .reveal(card: card, source: .hand(player), target: .hand(player)),
                                  duration: preferences.updateDelay)
        }
    }
    
    static func discardInPlay() -> EventDesc {
        EventDesc(id: "discardInPlay") { event in
            guard case let .discardInPlay(player, card) = event else {
                fatalError("Invalid event")
            }
            return EventAnimation(type: .move(card: card, source: .inPlay(player), target: .discard),
                                  duration: preferences.updateDelay)
        }
    }
    
    static func drawHand() -> EventDesc {
        EventDesc(id: "drawHand") { event in
            guard case let .drawHand(player, other, _) = event else {
                fatalError("Invalid event")
            } 
            return EventAnimation(type: .move(card: nil, source: .hand(other), target: .hand(player)),
                                  duration: preferences.updateDelay)
        }
    }
    
    static func drawInPlay() -> EventDesc {
        EventDesc(id: "drawInPlay") { event in
            guard case let .drawInPlay(player, other, card) = event else {
                fatalError("Invalid event")
            }
            return EventAnimation(type: .move(card: card, source: .inPlay(other), target: .hand(player)),
                                  duration: preferences.updateDelay)
        }
    }
    
    static func putInPlayOther() -> EventDesc {
        EventDesc(id: "putInPlayOther") { event in
            guard case let .putInPlayOther(player, card, other) = event else {
                fatalError("Invalid event")
            }
            return EventAnimation(type: .move(card: card, source: .hand(player), target: .inPlay(other)),
                                  duration: preferences.updateDelay)
        }
    }
    
    static func passInPlayOther() -> EventDesc {
        EventDesc(id: "passInPlayOther") { event in
            guard case let .passInPlayOther(player, card, other) = event else {
                fatalError("Invalid event")
            }
            return EventAnimation(type: .move(card: card, source: .inPlay(player), target: .inPlay(other)),
                                  duration: preferences.updateDelay)
        }
    }
    
    static func revealDeck() -> EventDesc {
        EventDesc(id: "revealDeck") { event in
            guard case .revealDeck = event else {
                fatalError("Invalid event")
            }
            return EventAnimation(type: .reveal(card: StateCard.deck, source: .deck, target: .discard),
                                  duration: preferences.updateDelay)
        }
    }
    
    static func deckToStore() -> EventDesc {
        EventDesc(id: "deckToStore") { event in
            guard case .deckToStore = event else {
                fatalError("Invalid event")
            }
            #warning("TODO: handle hidden store in animRenderer")
            return EventAnimation(type: .reveal(card: StateCard.deck, source: .deck, target: .store),
                                  duration: preferences.updateDelay)
        }
    }
    
    static func storeToDeck() -> EventDesc {
        EventDesc(id: "storeToDeck") { event in
            guard case let .storeToDeck(card) = event else {
                fatalError("Invalid event")
            }
            return EventAnimation(type: .move(card: card, source: .store, target: .deck),
                                  duration: preferences.updateDelay)
        }
    }
    
    static func drawStore() -> EventDesc {
        EventDesc(id: "drawStore") { event in
            guard case let .drawStore(player, card) = event else {
                fatalError("Invalid event")
            }
            return EventAnimation(type: .move(card: card, source: .store, target: .hand(player)),
                                  duration: preferences.updateDelay)
        }
    }
}

private extension UIEventMatcher {
    
    static let sfx: [String: String] = [
        "drawDeck": "Slide Closed-SoundBible.com-1521580537",
        "drawDiscard": "Slide Closed-SoundBible.com-1521580537",
        "putInPlay": "Shotgun-SoundBible.com-862990674",
        "revealHand": "Slide Closed-SoundBible.com-1521580537",
        "discardInPlay": "flyby-Conor-1500306612",
        "drawHand": "Slap-SoundMaster13-49669815",
        "drawInPlay": "Slap-SoundMaster13-49669815",
        "putInPlayOther": "Metal Latch-SoundBible.com-736691159",
        "passInPlayOther": "Fuse Burning-SoundBible.com-1372982430",
        "revealDeck": "Slide Closed-SoundBible.com-1521580537",
        "deckToStore": "Slide Closed-SoundBible.com-1521580537",
        "storeToDeck": "Slide Closed-SoundBible.com-1521580537",
        "drawStore": "Slide Closed-SoundBible.com-1521580537",
        "gainHealth": "Slurping 2-SoundBible.com-1269549524",
        "looseHealth": "342229_christopherderp_hurt-1-male (online-audio-converter.com)",
        "eliminate": "Pain-SoundBible.com-1883168362",
        "addHit": "Gun_loud-Soundmaster_-88363983"
    ]
}

/*

private let sfx: [MoveName: String] = [
    .stagecoach: "Horse Galloping-SoundBible.com-1451398148",
    .wellsFargo: "Horse Galloping-SoundBible.com-1451398148",
    .generalStore: "Horse Galloping-SoundBible.com-1451398148",
    .bang: "Gun_loud-Soundmaster_-88363983",
    .gatling: "Automatic Machine Gun-SoundBible.com-253461580",
    .indians: "Peacock-SoundBible.com-1698361099",
    .duel: "shotgun-old_school-RA_The_Sun_God-1129942741",
    .discardBang: "Gun_loud-Soundmaster_-88363983",
    .dynamiteExploded: "Big Bomb-SoundBible.com-1219802495",
    .escapeFromJail: "Ta Da-SoundBible.com-1884170640",
    .failBarrel: "Metal Clang-SoundBible.com-19572601",
    "missed": "Western Ricochet-SoundBible.com-1725886901",
]

private var equipSfx: [CardName: String] = [
    .barrel: "Cowboy_with_spurs-G-rant-1371954508",
    .mustang: "Cowboy_with_spurs-G-rant-1371954508",
    .scope: "Cowboy_with_spurs-G-rant-1371954508"
]
*/

private extension UIEventMatcher {
    
    static let emoji: [String: String] = [
        "play": "👍",
        "activate": "🎮",
        "emptyQueue": "💤",
        "gameover": "🎉",
        "setTurn": "🔥",
        "setPhase": "✔️",
        "gainHealth": "🍺",
        "looseHealth": "❤️",
        "eliminate": "☠️",
        "drawDeck": "💰",
        "drawHand": "‼️",
        "drawInPlay": "‼️",
        "drawDiscard": "💰",
        "drawStore": "💰",
        "putInPlay": "😎",
        "putInPlayOther": "⚠️",
        "passInPlayOther": "💣",
        "discardHand": "❌",
        "discardInPlay": "❌",
        "setStoreView": "",
        "deckToStore": "🎁",
        "storeToDeck": "❌",
        "revealDeck": "🌟",
        "revealHand": "🌟",
        "addHit": "🔫",
        "removeHit": "😝",
        "editHit": "😝"
    ]
}
