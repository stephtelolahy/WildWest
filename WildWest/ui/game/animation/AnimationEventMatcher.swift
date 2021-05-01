//
//  AnimationEventMatcher.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/11/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import WildWestEngine

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
    
    private let preferences: UserPreferencesProtocol
    
    init(preferences: UserPreferencesProtocol) {
        self.preferences = preferences
    }
    
    func waitDuration(_ event: GEvent) -> Double {
        guard animation(on: event) != nil else {
            return 0
        }
        
        return preferences.updateDelay
    }
    
    func animation(on event: GEvent) -> EventAnimation? {
        guard let eventDesc = Self.all[event.hashValue] else {
            return nil
        }
        
        return EventAnimation(type: eventDesc.animateFunc(event),
                              duration: preferences.updateDelay)
    }
}

private typealias EventAnimateFunc = (GEvent) -> EventAnimationType

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
            .dummy
        }
    }
    
    static func setPhase() -> EventDesc {
        EventDesc(id: "setPhase") { _ in
            .dummy
        }
    }
    
    static func gainHealth() -> EventDesc {
        EventDesc(id: "gainHealth") { _ in
            .dummy
        }
    }
    
    static func looseHealth() -> EventDesc {
        EventDesc(id: "looseHealth") { _ in
            .dummy
        }
    }
    
    static func eliminate() -> EventDesc {
        EventDesc(id: "eliminate") { _ in
            .dummy
        }
    }
    
    static func addHit() -> EventDesc {
        EventDesc(id: "addHit") { _ in
            .dummy
        }
    }
    
    static func drawDeck() -> EventDesc {
        EventDesc(id: "drawDeck") { event in
            guard case let .drawDeck(player) = event else {
                fatalError("Invalid event")
            }
            
            return .move(card: nil, source: .deck, target: .hand(player))
        }
    }
    
    static func drawDiscard() -> EventDesc {
        EventDesc(id: "drawDiscard") { event in
            guard case let .drawDiscard(player) = event else {
                fatalError("Invalid event")
            }
            return .move(card: StateCard.discard, source: .discard, target: .hand(player))
        }
    }
    
    static func discardHand() -> EventDesc {
        EventDesc(id: "discardHand") { event in
            guard case let .discardHand(player, card) = event else {
                fatalError("Invalid event")
            }
            return .move(card: card, source: .hand(player), target: .discard)
        }
    }
    
    static func play() -> EventDesc {
        EventDesc(id: "play") { event in
            guard case let .play(player, card) = event else {
                fatalError("Invalid event")
            }
            return .move(card: card, source: .hand(player), target: .discard)
        }
    }
    
    static func equip() -> EventDesc {
        EventDesc(id: "equip") { event in
            guard case let .equip(player, card) = event else {
                fatalError("Invalid event")
            }
            return .move(card: card, source: .hand(player), target: .inPlay(player))
        }
    }
    
    static func revealHand() -> EventDesc {
        EventDesc(id: "revealHand") { event in
            guard case let .revealHand(player, card) = event else {
                fatalError("Invalid event")
            }
            return .reveal(card: card, source: .hand(player), target: .hand(player))
        }
    }
    
    static func discardInPlay() -> EventDesc {
        EventDesc(id: "discardInPlay") { event in
            guard case let .discardInPlay(player, card) = event else {
                fatalError("Invalid event")
            }
            return .move(card: card, source: .inPlay(player), target: .discard)
        }
    }
    
    static func drawHand() -> EventDesc {
        EventDesc(id: "drawHand") { event in
            guard case let .drawHand(player, other, _) = event else {
                fatalError("Invalid event")
            }
            return .move(card: nil, source: .hand(other), target: .hand(player))
        }
    }
    
    static func drawInPlay() -> EventDesc {
        EventDesc(id: "drawInPlay") { event in
            guard case let .drawInPlay(player, other, card) = event else {
                fatalError("Invalid event")
            }
            return .move(card: card, source: .inPlay(other), target: .hand(player))
        }
    }
    
    static func handicap() -> EventDesc {
        EventDesc(id: "handicap") { event in
            guard case let .handicap(player, card, other) = event else {
                fatalError("Invalid event")
            }
            return .move(card: card, source: .hand(player), target: .inPlay(other))
        }
    }
    
    static func passInPlay() -> EventDesc {
        EventDesc(id: "passInPlay") { event in
            guard case let .passInPlay(player, card, other) = event else {
                fatalError("Invalid event")
            }
            return .move(card: card, source: .inPlay(player), target: .inPlay(other))
        }
    }
    
    static func revealDeck() -> EventDesc {
        EventDesc(id: "revealDeck") { event in
            guard case .revealDeck = event else {
                fatalError("Invalid event")
            }
            return .reveal(card: StateCard.deck, source: .deck, target: .discard)
        }
    }
    
    static func deckToStore() -> EventDesc {
        EventDesc(id: "deckToStore") { event in
            guard case .deckToStore = event else {
                fatalError("Invalid event")
            }
            return .reveal(card: StateCard.deck, source: .deck, target: .store)
        }
    }
    
    static func storeToDeck() -> EventDesc {
        EventDesc(id: "storeToDeck") { event in
            guard case let .storeToDeck(card) = event else {
                fatalError("Invalid event")
            }
            return .move(card: card, source: .store, target: .deck)
        }
    }
    
    static func drawStore() -> EventDesc {
        EventDesc(id: "drawStore") { event in
            guard case let .drawStore(player, card) = event else {
                fatalError("Invalid event")
            }
            return .move(card: card, source: .store, target: .hand(player))
        }
    }
}
