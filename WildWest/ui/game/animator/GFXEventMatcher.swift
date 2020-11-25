//
//  GFXEventMatcher.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/11/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import CardGameEngine

protocol GFXEventMatcherProtocol {
    func animation(on event: GEvent, in state: StateProtocol) -> EventAnimation?
}

enum EventAnimation {
    case move(sourceName: String?, targetName: String?, source: CardArea, target: CardArea)
    case reveal(sourceName: String?, targetName: String?, source: CardArea, target: CardArea)
}

enum CardArea: Hashable {
    case deck
    case discard
    case store
    case hand(String)
    case inPlay(String)
}

class GFXEventMatcher: GFXEventMatcherProtocol {
    
    func animation(on event: GEvent, in state: StateProtocol) -> EventAnimation? {
        guard let gfx = Self.gfx[event.hashValue] else {
            print("⚠️ No animation matching \(event)")
            return nil
        }
        
        return gfx.animateFunc(event, state)
    }
}

private typealias EventAnimateFunc = (GEvent, StateProtocol) -> EventAnimation

private struct EventDesc {
    let id: String
    let animateFunc: EventAnimateFunc
}

private extension GFXEventMatcher {
    
    static let gfx: [String: EventDesc] = [
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
    
    static func drawDeck() -> EventDesc {
        EventDesc(id: "drawDeck") { event, _ in
            guard case let .drawDeck(player) = event else {
                fatalError("Invalid event")
            }
            
            return .move(sourceName: nil,
                         targetName: nil, 
                         source: .deck, 
                         target: .hand(player))
        }
    }
    
    static func drawDiscard() -> EventDesc {
        EventDesc(id: "drawDiscard") { event, state in
            guard case let .drawDiscard(player) = event else {
                fatalError("Invalid event")
            }
            guard let cardObject = state.discard.first else {
                fatalError("Illegal state")
            }
            return .move(sourceName: cardObject.name, targetName: nil, source: .discard, target: .hand(player))
        }
    }
    
    static func discardHand() -> EventDesc {
        EventDesc(id: "discardHand") { event, state in
            guard case let .discardHand(player, card) = event else {
                fatalError("Invalid event")
            }
            guard let cardObject = state.players[player]?.hand.first(where: { $0.identifier == card })  else {
                fatalError("Illegal state")
            }
            return .move(sourceName: cardObject.name, 
                         targetName: state.discard.first?.name, 
                         source: .hand(player),
                         target: .discard)
        }
    }
    
    static func putInPlay() -> EventDesc {
        EventDesc(id: "putInPlay") { event, state in
            guard case let .putInPlay(player, card) = event else {
                fatalError("Invalid event")
            }
            guard let cardObject = state.players[player]?.hand.first(where: { $0.identifier == card }) else {
                fatalError("Illegal state")
            }
            return .move(sourceName: cardObject.name,
                         targetName: nil,
                         source: CardArea.hand(player),
                         target: .inPlay(player))
        }
    }
    
    static func revealHand() -> EventDesc {
        EventDesc(id: "revealHand") { event, state in
            guard case let .revealHand(player, card) = event else {
                fatalError("Invalid event")
            }
            
            guard let cardObject = state.players[player]?.hand.first(where: { $0.identifier == card }) else {
                fatalError("Illegal state")
            }
            return .reveal(sourceName: cardObject.name,
                           targetName: nil,
                           source: .hand(player),
                           target: .hand(player))
        }
    }
    
    static func discardInPlay() -> EventDesc {
        EventDesc(id: "discardInPlay") { event, state in
            guard case let .discardInPlay(player, card) = event else {
                fatalError("Invalid event")
            }
            
            guard let cardObject = state.players[player]?.inPlay.first(where: { $0.identifier == card }) else {
                fatalError("Illegal state")
            }
            return .move(sourceName: cardObject.name,
                         targetName: state.discard.first?.name,
                         source: .inPlay(player),
                         target: .discard)
        }
    }
    
    static func drawHand() -> EventDesc {
        EventDesc(id: "drawHand") { event, _ in
            guard case let .drawHand(player, other, _) = event else {
                fatalError("Invalid event")
            } 
            return .move(sourceName: nil, 
                         targetName: nil, 
                         source: .hand(other), 
                         target: .hand(player))
        }
    }
    
    static func drawInPlay() -> EventDesc {
        EventDesc(id: "drawInPlay") { event, state in
            guard case let .drawInPlay(player, other, card) = event else {
                fatalError("Invalid event")
            }
            guard let cardObject = state.players[other]?.inPlay.first(where: { $0.identifier == card }) else {
                fatalError("Illegal state")
            }
            return .move(sourceName: cardObject.name,
                         targetName: nil,
                         source: .inPlay(other),
                         target: .hand(player))
        }
    }
    
    static func putInPlayOther() -> EventDesc {
        EventDesc(id: "putInPlayOther") { event, state in
            guard case let .putInPlayOther(player, card, other) = event else {
                fatalError("Invalid event")
            }
            guard let cardObject = state.players[player]?.hand.first(where: { $0.identifier == card }) else {
                fatalError("Illegal state")
            }
            return .move(sourceName: cardObject.name,
                         targetName: nil,
                         source: .hand(player),
                         target: .inPlay(other))
        }
    }
    
    static func passInPlayOther() -> EventDesc {
        EventDesc(id: "passInPlayOther") { event, state in
            guard case let .passInPlayOther(player, card, other) = event else {
                fatalError("Invalid event")
            }
            
            guard let cardObject = state.players[player]?.inPlay.first(where: { $0.identifier == card }) else {
                fatalError("Illegal state")
            }
            
            return .move(sourceName: cardObject.name,
                         targetName: nil,
                         source: .inPlay(player),
                         target: .inPlay(other))
        }
    }
    
    static func revealDeck() -> EventDesc {
        EventDesc(id: "revealDeck") { event, state in
            guard case .revealDeck = event else {
                fatalError("Invalid event")
            }
            guard let cardObject = state.deck.first else {
                fatalError("Illegal state")
            }
            return .reveal(sourceName: cardObject.name, 
                           targetName: state.discard.first?.name,
                           source: .deck,
                           target: .discard)
        }
    }
    
    static func deckToStore() -> EventDesc {
        EventDesc(id: "deckToStore") { event, state in
            guard case .deckToStore = event else {
                fatalError("Invalid event")
            }
            guard let cardObject = state.deck.first else {
                fatalError("Illegal state")
            }
            
            let sourceName = state.storeView == nil ? cardObject.name : nil
            return .reveal(sourceName: sourceName,
                           targetName: nil,
                           source: .deck, 
                           target: .store)
        }
    }
    
    static func storeToDeck() -> EventDesc {
        EventDesc(id: "storeToDeck") { event, _ in
            guard case .storeToDeck = event else {
                fatalError("Invalid event")
            }
            
            return .reveal(sourceName: nil, targetName: nil, source: .store, target: .deck)
        }
    }
    
    static func drawStore() -> EventDesc {
        EventDesc(id: "drawStore") { event, state in
            guard case let .drawStore(player, card) = event else {
                fatalError("Invalid event")
            }
            guard let cardObject = state.store.first(where: { $0.identifier == card }) else {
                fatalError("Illegal state")
            }
            let sourceName = state.storeView == nil ? cardObject.name : nil
            return .move(sourceName: sourceName,
                         targetName: nil, 
                         source: .store,
                         target: .hand(player))
        }
    }
}
