//
//  RemoteGameDatabaseUpdater.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 06/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//
// swiftlint:disable file_length
// swiftlint:disable sorted_first_last

import RxSwift
import Firebase
import WildWestEngine

protocol RemoteGameDatabaseUpdaterProtocol {
    func execute(_ event: GEvent) -> Completable
}

class RemoteGameDatabaseUpdater: RemoteGameDatabaseUpdaterProtocol {
    
    private let gameRef: DatabaseReferenceProtocol
    
    init(gameRef: DatabaseReferenceProtocol) {
        self.gameRef = gameRef
    }
    
    func execute(_ event: GEvent) -> Completable {
        guard let eventDesc = Self.all[event.name] else {
            fatalError("No database transaction matching \(event)")
        }
        
        return eventDesc.updateFunc(event, gameRef)
    }
}

private typealias EventFunc = (GEvent, DatabaseReferenceProtocol) -> Completable
private typealias MatchingFunc = (GEvent) -> Bool

private struct EventDesc {
    let id: String
    let desc: String
    let updateFunc: EventFunc
}

private extension RemoteGameDatabaseUpdater {
    
    static let all: [String: EventDesc] = [
        run(),
        activate(),
        gameover(),
        setTurn(),
        setPhase(),
        gainHealth(),
        looseHealth(),
        eliminate(),
        drawDeck(),
        drawDeckFlipping(),
        drawHand(),
        drawInPlay(),
        drawStore(),
        drawDiscard(),
        equip(),
        handicap(),
        passInPlay(),
        discardHand(),
        play(),
        discardInPlay(),
        deckToStore(),
        storeToDeck(),
        flipDeck(),
        addHit(),
        removeHit(),
        cancelHit(),
        emptyQueue()
    ]
    .toDictionary(with: { $0.id })
    
    static func run() -> EventDesc {
        EventDesc(id: "run", desc: "add played ability") { event, gameRef in
            guard case let .run(move) = event else {
                fatalError("Invalid event")
            }
            return gameRef.rxSetValue("state/played/\(gameRef.childByAutoIdKey())") { move.ability }
        }
    }
    
    static func activate() -> EventDesc {
        EventDesc(id: "activate", desc: "activate moves") { event, _ in
            guard case .activate = event else {
                fatalError("Invalid event")
            }
            // do nothing
            return Completable.empty()
        }
    }
    
    static func gameover() -> EventDesc {
        EventDesc(id: "gameover", desc: "game is over") { event, _ in
            guard case .gameover = event else {
                fatalError("Invalid event")
            }
            // do nothing
            return Completable.empty()
        }
    }
    
    static func setTurn() -> EventDesc {
        EventDesc(id: "setTurn", desc: "set current turn, implicitly clear played abilities") { event, gameRef in
            guard case let .setTurn(player) = event else {
                fatalError("Invalid event")
            }
            
            return gameRef.rxSetValue("state/turn", encoding: { player })
                .andThen(gameRef.rxSetValue("state/played", encoding: { nil }))
        }
    }
    
    static func setPhase() -> EventDesc {
        EventDesc(id: "setPhase", desc: "set phase") { event, gameRef in
            guard case let .setPhase(value) = event else {
                fatalError("Invalid event")
            }
            return gameRef.rxSetValue("state/phase") { value }
        }
    }
    
    static func gainHealth() -> EventDesc {
        EventDesc(id: "gainHealth", desc: "Gain 1 life point") { event, gameRef in
            guard case let .gainHealth(player) = event else {
                fatalError("Invalid event")
            }
            
            return gameRef.rxObserveSingleEvent("state/players/\(player)/health", decoding: { snapshot -> Int in
                try (snapshot.value as? Int).unwrap()
            }).flatMapCompletable { health in
                gameRef.rxSetValue("state/players/\(player)/health") { health + 1 }
            }
        }
    }
    
    static func looseHealth() -> EventDesc {
        EventDesc(id: "looseHealth", desc: "Loose 1 life point") { event, gameRef in
            guard case let .looseHealth(player, _) = event else {
                fatalError("Invalid event")
            }
            return gameRef.rxObserveSingleEvent("state/players/\(player)/health", decoding: { snapshot -> Int in
                try (snapshot.value as? Int).unwrap()
            }).flatMapCompletable { health in
                gameRef.rxSetValue("state/players/\(player)/health") { health - 1 }
            }
        }
    }
    
    static func eliminate() -> EventDesc {
        EventDesc(id: "eliminate", desc: "Remove from playOrder") { event, gameRef in
            guard case let .eliminate(player, _) = event else {
                fatalError("Invalid event")
            }
            return gameRef.rxSetValue("state/players/\(player)/health", encoding: { 0 })
                .andThen(gameRef.rxObserveSingleEvent("state/playOrder", decoding: { snapshot -> [String]? in
                    snapshot.value as? [String]
                }).flatMapCompletable({ playOrder in
                    var value = playOrder ?? []
                    if let index = value.firstIndex(of: player) {
                        value.remove(at: index)
                    }
                    return gameRef.rxSetValue("state/playOrder") { value }
                }))
                .andThen(gameRef.rxObserveSingleEvent("state/hits", decoding: { snapshot -> [String: HitDto]? in
                    snapshot.value as? [String: HitDto]
                }).flatMapCompletable({ hits in
                    let hits = hits ?? [:]
                    var keysToRemove: [String] = []
                    for (key, value) in hits where value.player == player {
                        keysToRemove.append(key)
                    }
                    let completables: [Completable] = keysToRemove.map { gameRef.rxSetValue("state/hits/\($0)", encoding: { nil }) }
                    return Completable.concat(completables)
                }))
        }
    }
    
    static func drawDeck() -> EventDesc {
        EventDesc(id: "drawDeck", desc: "Draw top card from deck") { event, gameRef in
            guard case let .drawDeck(player) = event else {
                fatalError("Invalid event")
            }
            
            return resetDeckIfNeeded(gameRef)
                .andThen(gameRef.rxObserveSingleEvent("state/deck", decoding: { snapshot -> [String: String] in
                    try (snapshot.value as? [String: String]).unwrap()
                }).flatMapCompletable({ cards in
                    let deckKey = cards.keys.sorted().min()!
                    let removeDeckCompletable = gameRef.rxSetValue("state/deck/\(deckKey)") { nil }
                    let cardId = cards[deckKey]
                    let addHandCompletable = gameRef.rxSetValue("state/players/\(player)/hand/\(gameRef.childByAutoIdKey())") { cardId }
                    return Completable.concat(removeDeckCompletable, addHandCompletable)
                }))
        }
    }
    
    static func drawDeckFlipping() -> EventDesc {
        EventDesc(id: "drawDeckFlipping", desc: "Draw top card from deck then reveal") { event, gameRef in
            guard case let .drawDeckFlipping(player) = event else {
                fatalError("Invalid event")
            }
            
            return resetDeckIfNeeded(gameRef)
                .andThen(gameRef.rxObserveSingleEvent("state/deck", decoding: { snapshot -> [String: String] in
                    try (snapshot.value as? [String: String]).unwrap()
                }).flatMapCompletable({ cards in
                    let deckKey = cards.keys.sorted().min()!
                    let removeDeckCompletable = gameRef.rxSetValue("state/deck/\(deckKey)") { nil }
                    let cardId = cards[deckKey]
                    let addHandCompletable = gameRef.rxSetValue("state/players/\(player)/hand/\(gameRef.childByAutoIdKey())") { cardId }
                    return Completable.concat(removeDeckCompletable, addHandCompletable)
                }))
        }
    }
    
    static func drawHand() -> EventDesc {
        EventDesc(id: "drawHand", desc: "Draw a specific card from other's hand") { event, gameRef in
            guard case let .drawHand(player, other, card) = event else {
                fatalError("Invalid event")
            }
            
            return gameRef.rxObserveSingleEvent("state/players/\(other)/hand", decoding: { snapshot -> [String: String] in
                try (snapshot.value as? [String: String]).unwrap()
            }).flatMapCompletable { cards in
                let cardKey = cards.first(where: { $0.value == card })!.key
                return gameRef.rxSetValue("state/players/\(other)/hand/\(cardKey)", encoding: { nil })
                    .andThen(gameRef.rxSetValue("state/players/\(player)/hand/\(gameRef.childByAutoIdKey())", encoding: { card }))
            }
        }
    }
    
    static func drawInPlay() -> EventDesc {
        EventDesc(id: "drawInPlay", desc: "Draw a specific card from other's inPlay") { event, gameRef in
            guard case let .drawInPlay(player, other, card) = event else {
                fatalError("Invalid event")
            }
            
            return gameRef.rxObserveSingleEvent("state/players/\(other)/inPlay", decoding: { snapshot -> [String: String] in
                try (snapshot.value as? [String: String]).unwrap()
            }).flatMapCompletable { cards in
                let cardKey = cards.first(where: { $0.value == card })!.key
                return gameRef.rxSetValue("state/players/\(other)/inPlay/\(cardKey)", encoding: { nil })
                    .andThen(gameRef.rxSetValue("state/players/\(player)/hand/\(gameRef.childByAutoIdKey())", encoding: { card }))
            }
        }
    }
    
    static func drawStore() -> EventDesc {
        EventDesc(id: "drawStore", desc: "Draw a specific card from store") { event, gameRef in
            guard case let .drawStore(player, card) = event else {
                fatalError("Invalid event")
            }
            return gameRef.rxObserveSingleEvent("state/store", decoding: { snapshot -> [String: String] in
                try (snapshot.value as? [String: String]).unwrap()
            }).flatMapCompletable { cards in
                let cardKey = cards.first(where: { $0.value == card })!.key
                return gameRef.rxSetValue("state/store/\(cardKey)", encoding: { nil })
                    .andThen(gameRef.rxSetValue("state/players/\(player)/hand/\(gameRef.childByAutoIdKey())", encoding: { card }))
            }
        }
    }
    
    static func drawDiscard() -> EventDesc {
        EventDesc(id: "drawDiscard", desc: "Draw top card from discard") { event, gameRef in
            guard case let .drawDiscard(player) = event else {
                fatalError("Invalid event")
            }
            return gameRef.rxObserveSingleEvent("state/discard", decoding: { snapshot -> [String: String] in
                try (snapshot.value as? [String: String]).unwrap()
            }).flatMapCompletable { cards in
                let cardKey = cards.keys.sorted().max()!
                let card = cards[cardKey]
                return gameRef.rxSetValue("state/discard/\(cardKey)", encoding: { nil })
                    .andThen(gameRef.rxSetValue("state/players/\(player)/hand/\(gameRef.childByAutoIdKey())", encoding: { card }))
            }
        }
    }
    
    static func equip() -> EventDesc {
        EventDesc(id: "equip", desc: "Put a specific hand card in play") { event, gameRef in
            guard case let .equip(player, card) = event else {
                fatalError("Invalid event")
            }
            
            return gameRef.rxObserveSingleEvent("state/players/\(player)/hand", decoding: { snapshot -> [String: String] in
                try (snapshot.value as? [String: String]).unwrap()
            }).flatMapCompletable { cards in
                let cardKey = cards.first(where: { $0.value == card })!.key
                return gameRef.rxSetValue("state/players/\(player)/hand/\(cardKey)", encoding: { nil })
                    .andThen(gameRef.rxSetValue("state/players/\(player)/inPlay/\(gameRef.childByAutoIdKey())", encoding: { card }))
            }
        }
    }
    
    static func handicap() -> EventDesc {
        EventDesc(id: "handicap", desc: "Put a specific hand card in other's inPlay") { event, gameRef in
            guard case let .handicap(player, card, other) = event else {
                fatalError("Invalid event")
            }
            
            return gameRef.rxObserveSingleEvent("state/players/\(player)/hand", decoding: { snapshot -> [String: String] in
                try (snapshot.value as? [String: String]).unwrap()
            }).flatMapCompletable { cards in
                let cardKey = cards.first(where: { $0.value == card })!.key
                return gameRef.rxSetValue("state/players/\(player)/hand/\(cardKey)", encoding: { nil })
                    .andThen(gameRef.rxSetValue("state/players/\(other)/inPlay/\(gameRef.childByAutoIdKey())", encoding: { card }))
            }
        }
    }
    
    static func passInPlay() -> EventDesc {
        EventDesc(id: "passInPlay", desc: "Pass a specific inPlay card in other's inPlay") { event, gameRef in
            guard case let .passInPlay(player, card, other) = event else {
                fatalError("Invalid event")
            }
            
            return gameRef.rxObserveSingleEvent("state/players/\(player)/inPlay", decoding: { snapshot -> [String: String] in
                try (snapshot.value as? [String: String]).unwrap()
            }).flatMapCompletable { cards in
                let cardKey = cards.first(where: { $0.value == card })!.key
                return gameRef.rxSetValue("state/players/\(player)/inPlay/\(cardKey)", encoding: { nil })
                    .andThen(gameRef.rxSetValue("state/players/\(other)/inPlay/\(gameRef.childByAutoIdKey())", encoding: { card }))
            }
        }
    }
    
    static func discardHand() -> EventDesc {
        EventDesc(id: "discardHand", desc: "Discard a specific hand card to discard pile") { event, gameRef in
            guard case let .discardHand(player, card) = event else {
                fatalError("Invalid event")
            }
            
            return gameRef.rxObserveSingleEvent("state/players/\(player)/hand", decoding: { snapshot -> [String: String] in
                try (snapshot.value as? [String: String]).unwrap()
            }).flatMapCompletable { cards in
                let cardKey = cards.first(where: { $0.value == card })!.key
                return gameRef.rxSetValue("state/players/\(player)/hand/\(cardKey)", encoding: { nil })
                    .andThen(gameRef.rxSetValue("state/discard/\(gameRef.childByAutoIdKey())", encoding: { card }))
            }
        }
    }
    
    static func play() -> EventDesc {
        EventDesc(id: "play", desc: "Play hand card") { event, gameRef in
            guard case let .play(player, card) = event else {
                fatalError("Invalid event")
            }
            
            return gameRef.rxObserveSingleEvent("state/players/\(player)/hand", decoding: { snapshot -> [String: String] in
                try (snapshot.value as? [String: String]).unwrap()
            }).flatMapCompletable { cards in
                let cardKey = cards.first(where: { $0.value == card })!.key
                return gameRef.rxSetValue("state/players/\(player)/hand/\(cardKey)", encoding: { nil })
                    .andThen(gameRef.rxSetValue("state/discard/\(gameRef.childByAutoIdKey())", encoding: { card }))
            }
        }
    }
    
    static func discardInPlay() -> EventDesc {
        EventDesc(id: "discardInPlay", desc: "Discard a specific inPlay card to discard pile") { event, gameRef in
            guard case let .discardInPlay(player, card) = event else {
                fatalError("Invalid event")
            }
            
            return gameRef.rxObserveSingleEvent("state/players/\(player)/inPlay", decoding: { snapshot -> [String: String] in
                try (snapshot.value as? [String: String]).unwrap()
            }).flatMapCompletable { cards in
                let cardKey = cards.first(where: { $0.value == card })!.key
                return gameRef.rxSetValue("state/players/\(player)/inPlay/\(cardKey)", encoding: { nil })
                    .andThen(gameRef.rxSetValue("state/discard/\(gameRef.childByAutoIdKey())", encoding: { card }))
            }
        }
    }
    
    static func deckToStore() -> EventDesc {
        EventDesc(id: "deckToStore", desc: "Draw top card from deck to store") { event, gameRef in
            guard case .deckToStore = event else {
                fatalError("Invalid event")
            }
            
            return resetDeckIfNeeded(gameRef)
                .andThen(gameRef.rxObserveSingleEvent("state/deck", decoding: { snapshot -> [String: String] in
                    try (snapshot.value as? [String: String]).unwrap()
                }).flatMapCompletable({ cards in
                    let cardKey = cards.keys.sorted().min()!
                    let card = cards[cardKey]
                    return gameRef.rxSetValue("state/deck/\(cardKey)", encoding: { nil })
                        .andThen(gameRef.rxSetValue("state/store/\(gameRef.childByAutoIdKey())", encoding: { card }))
                }))
        }
    }
    
    static func storeToDeck() -> EventDesc {
        EventDesc(id: "storeToDeck", desc: "Draw top card from deck to store") { event, gameRef in
            guard case let .storeToDeck(card) = event else {
                fatalError("Invalid event")
            }
            
            return gameRef.rxObserveSingleEvent("state/store", decoding: { snapshot -> [String: String] in
                try (snapshot.value as? [String: String]).unwrap()
            }).flatMapCompletable { cards in
                let cardKey = cards.first(where: { $0.value == card })!.key
                return gameRef.rxSetValue("state/store/\(cardKey)", encoding: { nil })
                    .andThen(gameRef.rxSetValue("state/deck/\(gameRef.childByAutoIdKey())", encoding: { card }))
            }
        }
    }
    
    static func flipDeck() -> EventDesc {
        EventDesc(id: "flipDeck",
                  desc: "Flip over the top card of the deck, and discard immediately") { event, gameRef in
            guard case .flipDeck = event else {
                fatalError("Invalid event")
            }
            
            return resetDeckIfNeeded(gameRef)
                .andThen(gameRef.rxObserveSingleEvent("state/deck", decoding: { snapshot -> [String: String] in
                    try (snapshot.value as? [String: String]).unwrap()
                }).flatMapCompletable({ cards in
                    let cardKey = cards.keys.sorted().min()!
                    let card = cards[cardKey]
                    return gameRef.rxSetValue("state/deck/\(cardKey)", encoding: { nil })
                        .andThen(gameRef.rxSetValue("state/discard/\(gameRef.childByAutoIdKey())", encoding: { card }))
                }))
        }
    }
    
    static func addHit() -> EventDesc {
        EventDesc(id: "addHit", desc: "Add blocking hit") { event, gameRef in
            guard case let .addHit(player, name, abilities, cancelable, offender) = event else {
                fatalError("Invalid event")
            }
            
            let dto = HitDto(player: player,
                             name: name,
                             abilities: abilities,
                             cancelable: cancelable,
                             offender: offender)
            return gameRef.rxSetValue("state/hits/\(gameRef.childByAutoIdKey())", encoding: { try DictionaryEncoder().encode(dto) })
        }
    }
    
    static func removeHit() -> EventDesc {
        EventDesc(id: "removeHit", desc: "Remove hit by player") { event, gameRef in
            guard case let .removeHit(player) = event else {
                fatalError("Invalid event")
            }
            
            return gameRef.rxObserveSingleEvent("state/hits", decoding: { snapshot -> [String: Any] in
                try (snapshot.value as? [String: Any]).unwrap()
            }).flatMapCompletable { hits in
                let hitKey = hits.keys.sorted().first(where: { key in
                    if let hit = hits[key] as? [String: Any],
                       let aPlayer = hit["player"] as? String,
                       aPlayer == player {
                        return true
                    }
                    return false
                })!
                
                return gameRef.rxSetValue("state/hits/\(hitKey)", encoding: { nil })
            }
        }
    }
    
    static func cancelHit() -> EventDesc {
        EventDesc(id: "cancelHit", desc: "Decrement hit cancelable") { event, gameRef in
            guard case let .cancelHit(player) = event else {
                fatalError("Invalid event")
            }
            
            return gameRef.rxObserveSingleEvent("state/hits", decoding: { snapshot -> [String: Any] in
                try (snapshot.value as? [String: Any]).unwrap()
            }).flatMapCompletable { hits in
                var cancelable: Int?
                let hitKey = hits.keys.sorted().first(where: { key in
                    if let hit = hits[key] as? [String: Any],
                       let aPlayer = hit["player"] as? String,
                       aPlayer == player {
                        cancelable = hit["cancelable"] as? Int
                        return true
                    }
                    return false
                })!
                return gameRef.rxSetValue("state/hits/\(hitKey)/cancelable", encoding: { (try cancelable.unwrap()) - 1 })
            }
        }
    }
    
    static func emptyQueue() -> EventDesc {
        EventDesc(id: "emptyQueue", desc: "EventQueue is empty") { event, _ in
            guard case .emptyQueue = event else {
                fatalError("Invalid event")
            }
            // do nothing
            return Completable.empty()
        }
    }
}

private extension RemoteGameDatabaseUpdater {
    
    static func resetDeckIfNeeded(_ gameRef: DatabaseReferenceProtocol) -> Completable {
        let minDeck = 2
        return gameRef.rxObserveSingleEvent("state/deck", decoding: { snapshot -> [String: String] in
            try (snapshot.value as? [String: String]).unwrap()
        }).flatMapCompletable { deck in
            if deck.count > minDeck {
                // Do nothing
                return Completable.empty()
            }
            
            // Reset deck
            let minDiscard = 2
            return gameRef.rxObserveSingleEvent("state/discard", decoding: { snapshot -> [String: String] in
                try (snapshot.value as? [String: String]).unwrap()
            }).flatMapCompletable { discard in
                if discard.count < minDiscard {
                    return Completable.empty()
                }
                
                let topDiscardKey = discard.keys.sorted().reversed()[0]
                var cards = discard
                cards.removeValue(forKey: topDiscardKey)
                
                var completables: [Completable] = []
                for (key, value) in cards {
                    completables.append(gameRef.rxSetValue("state/discard/\(key)", encoding: { nil }))
                    completables.append(gameRef.rxSetValue("state/deck/\(gameRef.childByAutoIdKey())", encoding: { value }))
                }
                return Completable.concat(completables)
            }
        }
    }
}
