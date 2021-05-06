//
//  RemoteGameDatabaseUpdater.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 06/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import RxSwift
import Firebase
import WildWestEngine

protocol RemoteGameDatabaseUpdaterProtocol {
    func execute(_ event: GEvent) -> Completable
}

class RemoteGameDatabaseUpdater: RemoteGameDatabaseUpdaterProtocol {
    
    private let gameRef: DatabaseReference
    
    init(gameRef: DatabaseReference) {
        self.gameRef = gameRef
    }
    
    func execute(_ event: GEvent) -> Completable {
        guard let eventDesc = Self.all[event.hashValue] else {
            fatalError("No event description matching \(event)")
        }
        
        return eventDesc.updateFunc(event, gameRef)
    }
}

private typealias EventFunc = (GEvent, DatabaseReference) -> Completable
private typealias MatchingFunc = (GEvent) -> Bool

private struct EventDesc {
    let id: String
    let desc: String
    let updateFunc: EventFunc
}

private extension RemoteGameDatabaseUpdater {
    
    static let all: [String: EventDesc] = [
        run()
        /*
        activate(),
        gameover(),
        setTurn(),
        setPhase(),
        gainHealth(),
        looseHealth(),
        eliminate(),
        drawDeck(),
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
        setStoreView(),
        deckToStore(),
        storeToDeck(),
        revealDeck(),
        revealHand(),
        addHit(),
        removeHit(),
        cancelHit(),
        emptyQueue()
 */
    ]
    .toDictionary(with: { $0.id })
    
    static func run() -> EventDesc {
        EventDesc(id: "run", desc: "add played ability") { event, gameRef in
            guard case let .run(move) = event else {
                fatalError("Invalid event")
            }
            
            let key = FirebaseKeyGenerator().autoId()
            return gameRef.child("state/played/\(key)")
                .rxSetValue({ move.ability })
        }
    }
    /*
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
    
    static func setStoreView() -> EventDesc {
        EventDesc(id: "setStoreView", desc: "set specific player that can view store cards") { event, state in
            guard case let .setStoreView(player) = event else {
                fatalError("Invalid event")
            }
            state.storeView = player
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
    
    static func revealDeck() -> EventDesc {
        EventDesc(id: "revealDeck",
                  desc: "Flip over the top card of the deck, and discard immediately") { event, state in
            guard case .revealDeck = event else {
                fatalError("Invalid event")
            }
            state.resetDeckIfNeeded()
            let cardObject = state.deck.removeFirst()
            state.discard.insert(cardObject, at: 0)
        }
    }
    
    static func revealHand() -> EventDesc {
        EventDesc(id: "revealHand", desc: "Reveal a specific hand card,") { event, state in
            guard case let .revealHand(player, card) = event else {
                fatalError("Invalid event")
            }
            let playerObject = state.mutablePlayer(player)
            guard playerObject.hand.contains(where: { $0.identifier == card }) else {
                fatalError("Card \(card) not found")
            }
            // nothing to change on state
        }
    }
    
    static func addHit() -> EventDesc {
        EventDesc(id: "addHit", desc: "Add blocking hit") { event, state in
            guard case let .addHit(name, player, abilities, cancelable, offender) = event else {
                fatalError("Invalid event")
            }
            let hitObject = GHit(name: name,
                                 player: player,
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
 */
}

/*
// MARK: - Flags

func setTurn(_ turn: String) -> Completable {
    gameRef.child("state/turn")
        .rxSetValue({ turn })
}

func setChallenge(_ challenge: Challenge?) -> Completable {
    gameRef.child("state/challenge")
        .rxSetValue({ try self.mapper.encodeChallenge(challenge) })
}

func setOutcome(_ outcome: GameOutcome) -> Completable {
    gameRef.child("state/outcome")
        .rxSetValue({ outcome.rawValue })
}

// MARK: - Deck

func deckRemoveFirst() -> Single<CardProtocol> {
    resetDeck(when: 3)
        .andThen(pullDeck())
}

func discardRemoveFirst() -> Single<CardProtocol> {
    gameRef.child("state/discardPile").queryLimited(toLast: 1)
        .rxObserveSingleEvent({ try self.mapper.decodeCard(from: $0) })
        .flatMap { key, card in
            self.gameRef.child("state/discardPile/\(key)").rxSetValue({ nil })
                .andThen(Single.just(card))
        }
}

func addDeck(_ card: CardProtocol) -> Completable {
    gameRef.child("state/deck/-0")
        .rxSetValue({ card.identifier })
}

func addDiscard(_ card: CardProtocol) -> Completable {
    gameRef.child("state/discardPile").childByAutoId()
        .rxSetValue({ card.identifier })
}

// MARK: - General store

func addGeneralStore(_ card: CardProtocol) -> Completable {
    gameRef.child("state/generalStore/\(card.identifier)")
        .rxSetValue({ true })
}

func removeGeneralStore(_ cardId: String) -> Single<CardProtocol> {
    gameRef.child("state/generalStore/\(cardId)")
        .rxSetValue({ nil })
        .andThen(Single<CardProtocol>.create({ try self.mapper.decodeCard(from: cardId) }))
}

// MARK: - Player

func playerSetHealth(_ playerId: String, _ health: Int) -> Completable {
    gameRef.child("state/players/\(playerId)/health")
        .rxSetValue({ health })
}

func playerAddHand(_ playerId: String, _ card: CardProtocol) -> Completable {
    gameRef.child("state/players/\(playerId)/hand/\(card.identifier)")
        .rxSetValue({ true })
}

func playerRemoveHand(_ playerId: String, _ cardId: String) -> Single<CardProtocol> {
    gameRef.child("state/players/\(playerId)/hand/\(cardId)")
        .rxSetValue({ nil })
        .andThen(Single<CardProtocol>.create({ try self.mapper.decodeCard(from: cardId) }))
}

func playerAddInPlay(_ playerId: String, _ card: CardProtocol) -> Completable {
    gameRef.child("state/players/\(playerId)/inPlay/\(card.identifier)")
        .rxSetValue({ true })
}

func playerRemoveInPlay(_ playerId: String, _ cardId: String) -> Single<CardProtocol> {
    gameRef.child("state/players/\(playerId)/inPlay/\(cardId)")
        .rxSetValue({ nil })
        .andThen(Single<CardProtocol>.create({ try self.mapper.decodeCard(from: cardId) }))
}

func playerSetBangsPlayed(_ playerId: String, _ bangsPlayed: Int) -> Completable {
    gameRef.child("state/players/\(playerId)/bangsPlayed")
        .rxSetValue({ bangsPlayed })
}

func playerSetDamageEvent(_ playerId: String, _ event: DamageEvent) -> Completable {
    gameRef.child("state/players/\(playerId)/lastDamage")
        .rxSetValue({ try self.mapper.encodeDamageEvent(event) })
}

// MARK: - Events

func setExecutedUpdate(_ update: GameUpdate) -> Completable {
    gameRef.child("executedUpdate")
        .rxSetValue({ try self.mapper.encodeUpdate(update) })
}

func setExecutedMove(_ move: GameMove) -> Completable {
    gameRef.child("executedMove")
        .rxSetValue({ try self.mapper.encodeMove(move) })
}

func setValidMoves(_ moves: [GameMove]) -> Completable {
    gameRef.child("validMoves")
        .rxSetValue({ try self.mapper.encodeMoves(moves) })
}
 
 func resetDeck(when minSize: Int) -> Completable {
     var oldDeck: [CardProtocol] = []
     var oldDiscard: [CardProtocol] = []
     var newDeck: [CardProtocol] = []
     var newDiscard: [CardProtocol] = []
     
     let queryDeck = gameRef.child("state/deck").queryLimited(toFirst: UInt(minSize + 1))
         .rxObserveSingleEvent({ try self.mapper.decodeCards(from: $0) })
         .flatMapCompletable { cards in
             guard cards.count <= minSize else {
                 return Completable.error(NSError(domain: "enough cards", code: 0))
             }
             
             oldDeck = cards
             return Completable.empty()
         }
     
     let queryDiscardPile = gameRef.child("state/discardPile").queryOrderedByKey()
         .rxObserveSingleEvent({ try self.mapper.decodeCards(from: $0) })
         .flatMapCompletable { cards in
             oldDiscard = cards.reversed()
             newDiscard = Array(oldDiscard[0..<1])
             newDeck = (oldDeck + Array(oldDiscard[1..<oldDiscard.count])).shuffled()
             return Completable.empty()
         }
     
     let updateDeck = self.gameRef.child("state/deck")
         .rxSetValue({ try self.mapper.encodeOrderedCards(newDeck) })
     
     let updateDiscardPile = self.gameRef.child("state/discardPile")
         .rxSetValue({ try self.mapper.encodeOrderedCards(newDiscard) })
     
     return queryDeck
         .andThen(queryDiscardPile)
         .andThen(updateDeck)
         .andThen(updateDiscardPile)
         .catchError({ _ in Completable.empty() })
 }
 
 func pullDeck() -> Single<CardProtocol> {
     gameRef.child("state/deck").queryLimited(toFirst: 1)
         .rxObserveSingleEvent({ try self.mapper.decodeCard(from: $0) })
         .flatMap { key, card in
             self.gameRef.child("state/deck/\(key)").rxSetValue({ nil })
                 .andThen(Single.just(card))
         }
 }
 */
