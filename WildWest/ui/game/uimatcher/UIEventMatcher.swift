//
//  UIEventMatcher.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/11/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import CardGameEngine

protocol UIEventMatcherProtocol: EventMatcherProtocol {
    func animation(on event: GEvent, in state: StateProtocol) -> EventAnimation?
    func sfx(on event: GEvent) -> String?
    func emoji(_ event: GEvent) -> String?
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

class UIEventMatcher: UIEventMatcherProtocol {
    
    func waitDuration(_ event: GEvent) -> Double {
        #warning("TODO: implement")
        return 1
    }
    
    func animation(on event: GEvent, in state: StateProtocol) -> EventAnimation? {
        guard let gfx = Self.gfx[event.hashValue] else {
            print("⚠️ No animation matching \(event)")
            return nil
        }
        
        return gfx.animateFunc(event, state)
    }
    
    func sfx(on event: GEvent) -> String? {
        Self.sfx[event.hashValue]
    }
    
    func emoji(_ event: GEvent) -> String? {
        Self.emoji[event.hashValue]
    }
}

private typealias EventAnimateFunc = (GEvent, StateProtocol) -> EventAnimation

private struct EventDesc {
    let id: String
    let animateFunc: EventAnimateFunc
}

private extension UIEventMatcher {
    
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
