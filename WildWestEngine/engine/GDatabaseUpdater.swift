//
//  GDatabaseUpdater.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 14/11/2020.
//

public protocol GDatabaseUpdaterProtocol {
    func execute(_ event: GEvent, in state: GState)
}

public class GDatabaseUpdater: GDatabaseUpdaterProtocol {
    
    public init() {
    }
    
    public func execute(_ event: GEvent, in state: GState) {
        guard let eventDesc = Self.all[event.name] else {
            fatalError("No event description matching \(event)")
        }
        eventDesc.updateFunc(event, state)
    }
}

private typealias EventFunc = (GEvent, GState) -> Void

private struct EventDesc {
    let id: String
    let desc: String
    let updateFunc: EventFunc
}

private extension GDatabaseUpdater {
    
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
        drawDiscard(),
        drawStore(),
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
        EventDesc(id: "run", desc: "add played ability") { event, state in
            guard case let .run(move) = event else {
                fatalError("Invalid event")
            }
            state.played.append(move.ability)
        }
    }
    
    static func activate() -> EventDesc {
        EventDesc(id: "activate", desc: "activate moves") { event, _ in
            guard case .activate = event else {
                fatalError("Invalid event")
            }
            // do nothing
        }
    }
    
    static func gameover() -> EventDesc {
        EventDesc(id: "gameover", desc: "game is over") { event, _ in
            guard case .gameover = event else {
                fatalError("Invalid event")
            }
            // do nothing
        }
    }
    
    static func setTurn() -> EventDesc {
        EventDesc(id: "setTurn", desc: "set current turn, implicitly clear played abilities") { event, state in
            guard case let .setTurn(player) = event else {
                fatalError("Invalid event")
            }
            state.turn = player
            state.played.removeAll()
        }
    }
    
    static func setPhase() -> EventDesc {
        EventDesc(id: "setPhase", desc: "set phase") { event, state in
            guard case let .setPhase(value) = event else {
                fatalError("Invalid event")
            }
            state.phase = value
        }
    }
    
    static func gainHealth() -> EventDesc {
        EventDesc(id: "gainHealth", desc: "Gain 1 life point") { event, state in
            guard case let .gainHealth(player) = event else {
                fatalError("Invalid event")
            }
            state.mutablePlayer(player).health += 1
        }
    }
    
    static func looseHealth() -> EventDesc {
        EventDesc(id: "looseHealth", desc: "Loose 1 life point") { event, state in
            guard case let .looseHealth(player, _) = event else {
                fatalError("Invalid event")
            }
            state.mutablePlayer(player).health -= 1
        }
    }
    
    static func eliminate() -> EventDesc {
        EventDesc(id: "eliminate", desc: "Remove from playOrder") { event, state in
            guard case let .eliminate(player, _) = event else {
                fatalError("Invalid event")
            }
            guard let index = state.playOrder.firstIndex(where: { $0 == player }) else {
                fatalError("Player \(player) not in playOrder")
            }
            state.playOrder.remove(at: index)
            state.hits.removeAll(where: { $0.player == player })
            state.mutablePlayer(player).health = 0
        }
    }
    
    static func drawDeck() -> EventDesc {
        EventDesc(id: "drawDeck", desc: "Draw top card from deck") { event, state in
            guard case let .drawDeck(player) = event else {
                fatalError("Invalid event")
            }
            state.resetDeckIfNeeded()
            let cardObject = state.deck.removeFirst()
            state.mutablePlayer(player).hand.append(cardObject)
        }
    }
    
    static func drawHand() -> EventDesc {
        EventDesc(id: "drawHand", desc: "Draw a specific card from other's hand") { event, state in
            guard case let .drawHand(player, other, card) = event else {
                fatalError("Invalid event")
            }
            let otherObject = state.mutablePlayer(other)
            guard let index = otherObject.hand.firstIndex(where: { $0.identifier == card }) else {
                fatalError("Card \(card) not found")
            }
            let cardObject = otherObject.hand.remove(at: index)
            state.mutablePlayer(player).hand.append(cardObject)
        }
    }
    
    static func drawInPlay() -> EventDesc {
        EventDesc(id: "drawInPlay", desc: "Draw a specific card from other's inPlay") { event, state in
            guard case let .drawInPlay(player, other, card) = event else {
                fatalError("Invalid event")
            }
            let otherObject = state.mutablePlayer(other)
            guard let index = otherObject.inPlay.firstIndex(where: { $0.identifier == card }) else {
                fatalError("Card \(card) not found")
            }
            let cardObject = otherObject.inPlay.remove(at: index)
            state.mutablePlayer(player).hand.append(cardObject)
        }
    }
    
    static func drawStore() -> EventDesc {
        EventDesc(id: "drawStore", desc: "Draw a specific card from store") { event, state in
            guard case let .drawStore(player, card) = event else {
                fatalError("Invalid event")
            }
            guard let index = state.store.firstIndex(where: { $0.identifier == card }) else {
                fatalError("Card \(card) not found")
            }
            let cardObject = state.store.remove(at: index)
            state.mutablePlayer(player).hand.append(cardObject)
        }
    }
    
    static func drawDiscard() -> EventDesc {
        EventDesc(id: "drawDiscard", desc: "Draw top card from discard") { event, state in
            guard case let .drawDiscard(player) = event else {
                fatalError("Invalid event")
            }
            let cardObject = state.discard.removeFirst()
            state.mutablePlayer(player).hand.append(cardObject)
        }
    }
    
    static func equip() -> EventDesc {
        EventDesc(id: "equip", desc: "Put a specific hand card in play") { event, state in
            guard case let .equip(player, card) = event else {
                fatalError("Invalid event")
            }
            let playerObject = state.mutablePlayer(player)
            guard let index = playerObject.hand.firstIndex(where: { $0.identifier == card }) else {
                fatalError("Card \(card) not found")
            }
            let cardObject = playerObject.hand.remove(at: index)
            state.mutablePlayer(player).inPlay.append(cardObject)
        }
    }
    
    static func handicap() -> EventDesc {
        EventDesc(id: "handicap", desc: "Put a specific hand card in other's inPlay") { event, state in
            guard case let .handicap(player, card, other) = event else {
                fatalError("Invalid event")
            }
            let playerObject = state.mutablePlayer(player)
            guard let index = playerObject.hand.firstIndex(where: { $0.identifier == card }) else {
                fatalError("Card \(card) not found")
            }
            let cardObject = playerObject.hand.remove(at: index)
            state.mutablePlayer(other).inPlay.append(cardObject)
        }
    }
    
    static func passInPlay() -> EventDesc {
        EventDesc(id: "passInPlay", desc: "Pass a specific inPlay card in other's inPlay") { event, state in
            guard case let .passInPlay(player, card, other) = event else {
                fatalError("Invalid event")
            }
            let playerObject = state.mutablePlayer(player)
            guard let index = playerObject.inPlay.firstIndex(where: { $0.identifier == card }) else {
                fatalError("Card \(card) not found")
            }
            let cardObject = playerObject.inPlay.remove(at: index)
            state.mutablePlayer(other).inPlay.append(cardObject)
        }
    }
    
    static func discardHand() -> EventDesc {
        EventDesc(id: "discardHand", desc: "Discard a specific hand card to discard pile") { event, state in
            guard case let .discardHand(player, card) = event else {
                fatalError("Invalid event")
            }
            let playerObject = state.mutablePlayer(player)
            guard let index = playerObject.hand.firstIndex(where: { $0.identifier == card }) else {
                fatalError("Card \(card) not found")
            }
            let cardObject = playerObject.hand.remove(at: index)
            state.discard.insert(cardObject, at: 0)
        }
    }
    
    static func play() -> EventDesc {
        EventDesc(id: "play", desc: "Play hand card") { event, state in
            guard case let .play(player, card) = event else {
                fatalError("Invalid event")
            }
            let playerObject = state.mutablePlayer(player)
            guard let index = playerObject.hand.firstIndex(where: { $0.identifier == card }) else {
                fatalError("Card \(card) not found")
            }
            let cardObject = playerObject.hand.remove(at: index)
            state.discard.insert(cardObject, at: 0)
        }
    }
    
    static func discardInPlay() -> EventDesc {
        EventDesc(id: "discardInPlay", desc: "Discard a specific inPlay card to discard pile") { event, state in
            guard case let .discardInPlay(player, card) = event else {
                fatalError("Invalid event")
            }
            let playerObject = state.mutablePlayer(player)
            guard let index = playerObject.inPlay.firstIndex(where: { $0.identifier == card }) else {
                fatalError("Card \(card) not found")
            }
            let cardObject = playerObject.inPlay.remove(at: index)
            state.discard.insert(cardObject, at: 0)
        }
    }
    
    static func deckToStore() -> EventDesc {
        EventDesc(id: "deckToStore", desc: "Draw top card from deck to store") { event, state in
            guard case .deckToStore = event else {
                fatalError("Invalid event")
            }
            state.resetDeckIfNeeded()
            let cardObject = state.deck.removeFirst()
            state.store.append(cardObject)
        }
    }
    
    static func storeToDeck() -> EventDesc {
        EventDesc(id: "storeToDeck", desc: "Draw top card from deck to store") { event, state in
            guard case let .storeToDeck(card) = event else {
                fatalError("Invalid event")
            }
            guard let index = state.store.firstIndex(where: { $0.identifier == card }) else {
                fatalError("Card \(card) not found")
            }
            let cardObject = state.store.remove(at: index)
            state.deck.insert(cardObject, at: 0)
        }
    }
    
    static func flipDeck() -> EventDesc {
        EventDesc(id: "flipDeck", 
                  desc: "Flip over the top card of the deck, and discard immediately") { event, state in
            guard case .flipDeck = event else {
                fatalError("Invalid event")
            }
            state.resetDeckIfNeeded()
            let cardObject = state.deck.removeFirst()
            state.discard.insert(cardObject, at: 0)
        }
    }
    
    static func drawDeckFlipping() -> EventDesc {
        EventDesc(id: "drawDeckFlipping", desc: "Draw top card from deck then reveal") { event, state in
            guard case let .drawDeckFlipping(player) = event else {
                fatalError("Invalid event")
            }
            state.resetDeckIfNeeded()
            let cardObject = state.deck.removeFirst()
            state.mutablePlayer(player).hand.append(cardObject)
        }
    }
    
    static func addHit() -> EventDesc {
        EventDesc(id: "addHit", desc: "Add blocking hit") { event, state in
            guard case let .addHit(player, name, abilities, cancelable, offender) = event else {
                fatalError("Invalid event")
            }
            let hitObject = GHit(player: player,
                                 name: name,
                                 abilities: abilities,
                                 cancelable: cancelable,
                                 offender: offender)
            state.hits.append(hitObject)
        }
    }
    
    static func removeHit() -> EventDesc {
        EventDesc(id: "removeHit", desc: "Remove hit by player") { event, state in
            guard case let .removeHit(player) = event else {
                fatalError("Invalid event")
            }
            guard let index = state.hits.firstIndex(where: { $0.player == player }) else {
                return
            }
            state.hits.remove(at: index)
        }
    }
    
    static func cancelHit() -> EventDesc {
        EventDesc(id: "cancelHit", desc: "Decrement hit cancelable") { event, state in
            guard case let .cancelHit(player) = event else {
                fatalError("Invalid event")
            }
            guard let index = state.hits.firstIndex(where: { $0.player == player }),
                  let hitObject = state.hits[index] as? GHit else {
                fatalError("No editable hit matching player \(player)")
            }
            hitObject.cancelable -= 1
        }
    }
    
    static func emptyQueue() -> EventDesc {
        EventDesc(id: "emptyQueue", desc: "EventQueue is empty") { event, _ in
            guard case .emptyQueue = event else {
                fatalError("Invalid event")
            }
        }
        // do nothing
    }
}

private extension GState {
    
    func mutablePlayer(_ identifier: String) -> GPlayer {
        guard let playerObject = players[identifier] as? GPlayer else {
            fatalError("player \(identifier) not editable")
        }
        return playerObject
    }
    
    func resetDeckIfNeeded() {
        let minDeck = 2
        let minDiscard = 2
        guard deck.count <= minDeck,
              discard.count >= minDiscard else {
            return
        }
        
        let cards = discard
        deck.append(contentsOf: Array(cards[1..<cards.count]).shuffled())
        discard = Array(cards[0..<1])
    }
}
