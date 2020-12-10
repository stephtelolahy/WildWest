//
//  AnimationEventMatcher.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/11/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import CardGameEngine
import Resolver

protocol AnimationEventMatcherProtocol: DurationMatcherProtocol {
    func animation(on event: GEvent) -> EventAnimation?
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

class AnimationEventMatcher: AnimationEventMatcherProtocol {
    
    static let preferences: UserPreferencesProtocol = Resolver.resolve()
    
    func waitDuration(_ event: GEvent) -> Double {
        guard let anim = animation(on: event) else {
            return 0
        }
        
        return anim.duration
    }
    
    func animation(on event: GEvent) -> EventAnimation? {
        guard let eventDesc = Self.all[event.hashValue] else {
            return nil
        }
        
        return eventDesc.animateFunc(event)
    }
}

private typealias EventAnimateFunc = (GEvent) -> EventAnimation

private struct EventDesc {
    let id: String
    let animateFunc: EventAnimateFunc
}

private extension AnimationEventMatcher {
    
    static let all: [String: EventDesc] = [
        setTurn(),
        setPhase(),
        gainHealth(),
        looseHealth(),
        eliminate(),
        addHit(),
        drawDeck(),
        drawDiscard(),
        discardHand(),
        play(),
        equip(),
        revealHand(),
        discardInPlay(),
        drawHand(),
        drawInPlay(),
        handicap(),
        passInPlay(),
        revealDeck(),
        deckToStore(),
        storeToDeck(),
        drawStore()
    ]
    .toDictionary(with: { $0.id })
    
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
    
    static func play() -> EventDesc {
        EventDesc(id: "play") { event in
            guard case let .play(player, card) = event else {
                fatalError("Invalid event")
            }
            return EventAnimation(type: .move(card: card, source: .hand(player), target: .discard),
                                  duration: preferences.updateDelay)
        }
    }
    
    static func equip() -> EventDesc {
        EventDesc(id: "equip") { event in
            guard case let .equip(player, card) = event else {
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
    
    static func handicap() -> EventDesc {
        EventDesc(id: "handicap") { event in
            guard case let .handicap(player, card, other) = event else {
                fatalError("Invalid event")
            }
            return EventAnimation(type: .move(card: card, source: .hand(player), target: .inPlay(other)),
                                  duration: preferences.updateDelay)
        }
    }
    
    static func passInPlay() -> EventDesc {
        EventDesc(id: "passInPlay") { event in
            guard case let .passInPlay(player, card, other) = event else {
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
