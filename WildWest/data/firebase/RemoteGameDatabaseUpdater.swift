//
//  RemoteGameDatabaseUpdater.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 06/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//
// swiftlint:disable cyclomatic_complexity
// swiftlint:disable function_body_length

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
        switch event {
        case let .run(move):
            return gameRef.run(move)
            
        case let .setTurn(player):
            return gameRef.setTurn(player)
            
        case let .setPhase(value):
            return gameRef.setPhase(value)
            
        case let .gainHealth(player):
            return gameRef.gainHealth(player)
            
        case let .looseHealth(player, _):
            return gameRef.looseHealth(player)
            
        case let .eliminate(player, _):
            return gameRef.eliminate(player)
            
        case let .drawDeck(player):
            return gameRef.drawDeck(player)
            
        case let .drawDeckChoosing(player, card):
            return gameRef.drawDeckChoosing(player: player, card: card)
            
        case let .drawDeckFlipping(player):
            return gameRef.drawDeckFlipping(player)
            
        case let .drawHand(player, other, card):
            return gameRef.drawHand(player: player, other: other, card: card)
            
        case let .drawInPlay(player, other, card):
            return gameRef.drawInPlay(player: player, other: other, card: card)
            
        case let .drawStore(player, card):
            return gameRef.drawStore(player: player, card: card)
            
        case let .drawDiscard(player):
            return gameRef.drawDiscard(player)
            
        case let .equip(player, card):
            return gameRef.equip(player: player, card: card)
            
        case let .handicap(player, card, other):
            return gameRef.handicap(player: player, card: card, other: other)
            
        case let .passInPlay(player, card, other):
            return gameRef.passInPlay(player: player, card: card, other: other)
            
        case let .discardHand(player, card):
            return gameRef.discardHand(player: player, card: card)
            
        case let .play(player, card):
            return gameRef.play(player: player, card: card)
            
        case let .discardInPlay(player, card):
            return gameRef.discardInPlay(player: player, card: card)
            
        case .deckToStore:
            return gameRef.deckToStore()
            
        case .flipDeck:
            return gameRef.flipDeck()
            
        case let .addHit(hit):
            return gameRef.addHit(hit)
            
        case let .removeHit(player):
            return gameRef.removeHit(player)
            
        case .decrementHitCancelable:
            return gameRef.decrementHitCancelable()
            
        case let .gameover(winner):
            return gameRef.gameover(winner)
        
        default:
            return Completable.empty()
        }
    }
}

private extension DatabaseReferenceProtocol {
    
    // MARK: - Flags
    
    func run(_ move: GMove) -> Completable {
        rxSetValue("state/played/\(childByAutoIdKey())") { move.ability }
    }
    
    func setTurn(_ player: String) -> Completable {
        rxSetValue("state/turn", encoding: { player })
            .andThen(rxSetValue("state/played", encoding: { nil }))
    }
    
    func setPhase(_ phase: Int) -> Completable {
        rxSetValue("state/phase") { phase }
    }
    
    func gameover(_ winner: Role) -> Completable {
        rxSetValue("state/winner", encoding: { winner.rawValue })
    }
    
    // MARK: - Health
    
    func gainHealth(_ player: String) -> Completable {
        rxObserveSingleEvent("state/players/\(player)/health", decoding: { snapshot -> Int in
            try (snapshot.value as? Int).unwrap()
        }).flatMapCompletable { health in
            rxSetValue("state/players/\(player)/health") { health + 1 }
        }
    }
    
    func looseHealth(_ player: String) -> Completable {
        rxObserveSingleEvent("state/players/\(player)/health", decoding: { snapshot -> Int in
            try (snapshot.value as? Int).unwrap()
        }).flatMapCompletable { health in
            rxSetValue("state/players/\(player)/health") { health - 1 }
        }
    }
    
    func eliminate(_ player: String) -> Completable {
        rxSetValue("state/players/\(player)/health", encoding: { 0 })
            .andThen(rxObserveSingleEvent("state/playOrder", decoding: { snapshot -> [String]? in
                snapshot.value as? [String]
            }).flatMapCompletable({ playOrder in
                guard var playOrder = playOrder else {
                    return Completable.empty()
                }
                
                playOrder.removeAll(where: { $0 == player })
                return rxSetValue("state/playOrder") { playOrder }
            }))
            .andThen(rxObserveSingleEvent("state/hit/players", decoding: { snapshot -> [String]? in
                snapshot.value as? [String]
            }).flatMapCompletable({ hitPlayers in
                guard var hitPlayers = hitPlayers else {
                    return Completable.empty()
                }
                
                hitPlayers.removeAll(where: { $0 == player })
                
                if hitPlayers.isEmpty {
                    return rxSetValue("state/hit", encoding: { nil })
                } else {
                    return rxSetValue("state/hit/players", encoding: { hitPlayers })
                }
            }))
    }
    
    // MARK: - Draw
    
    func drawDeck(_ player: String) -> Completable {
        resetDeckIfNeeded()
            .andThen(rxObserveSingleEvent("state/deck", decoding: { snapshot -> [String: String] in
                try (snapshot.value as? [String: String]).unwrap()
            }).flatMapCompletable({ cards in
                let deckKey = cards.keys.sorted().min()!
                let removeDeckCompletable = rxSetValue("state/deck/\(deckKey)") { nil }
                let card = cards[deckKey]
                let addHandCompletable = rxSetValue("state/players/\(player)/hand/\(childByAutoIdKey())") { card }
                return Completable.concat(removeDeckCompletable, addHandCompletable)
            }))
    }
    
    func drawDeckChoosing(player: String, card: String) -> Completable {
        resetDeckIfNeeded()
            .andThen(rxObserveSingleEvent("state/deck", decoding: { snapshot -> [String: String] in
                try (snapshot.value as? [String: String]).unwrap()
            }).flatMapCompletable({ cards in
                let deckKey = cards.first(where: { $0.value == card })!.key
                let removeDeckCompletable = rxSetValue("state/deck/\(deckKey)") { nil }
                let addHandCompletable = rxSetValue("state/players/\(player)/hand/\(childByAutoIdKey())") { card }
                return Completable.concat(removeDeckCompletable, addHandCompletable)
            }))
    }
    
    func drawDeckFlipping(_ player: String) -> Completable {
        resetDeckIfNeeded()
            .andThen(rxObserveSingleEvent("state/deck", decoding: { snapshot -> [String: String] in
                try (snapshot.value as? [String: String]).unwrap()
            }).flatMapCompletable({ cards in
                let deckKey = cards.keys.sorted().min()!
                let removeDeckCompletable = rxSetValue("state/deck/\(deckKey)") { nil }
                let card = cards[deckKey]
                let addHandCompletable = rxSetValue("state/players/\(player)/hand/\(childByAutoIdKey())") { card }
                return Completable.concat(removeDeckCompletable, addHandCompletable)
            }))
        
    }
    
    func drawHand(player: String, other: String, card: String) -> Completable {
        rxObserveSingleEvent("state/players/\(other)/hand", decoding: { snapshot -> [String: String] in
            try (snapshot.value as? [String: String]).unwrap()
        }).flatMapCompletable { cards in
            let cardKey = cards.first(where: { $0.value == card })!.key
            return rxSetValue("state/players/\(other)/hand/\(cardKey)", encoding: { nil })
                .andThen(rxSetValue("state/players/\(player)/hand/\(childByAutoIdKey())", encoding: { card }))
        }
    }
    
    func drawInPlay(player: String, other: String, card: String) -> Completable {
        rxObserveSingleEvent("state/players/\(other)/inPlay", decoding: { snapshot -> [String: String] in
            try (snapshot.value as? [String: String]).unwrap()
        }).flatMapCompletable { cards in
            let cardKey = cards.first(where: { $0.value == card })!.key
            return rxSetValue("state/players/\(other)/inPlay/\(cardKey)", encoding: { nil })
                .andThen(rxSetValue("state/players/\(player)/hand/\(childByAutoIdKey())", encoding: { card }))
        }
    }
    
    func drawStore(player: String, card: String) -> Completable {
        rxObserveSingleEvent("state/store", decoding: { snapshot -> [String: String] in
            try (snapshot.value as? [String: String]).unwrap()
        }).flatMapCompletable { cards in
            let cardKey = cards.first(where: { $0.value == card })!.key
            return rxSetValue("state/store/\(cardKey)", encoding: { nil })
                .andThen(rxSetValue("state/players/\(player)/hand/\(childByAutoIdKey())", encoding: { card }))
        }
    }
    
    func drawDiscard(_ player: String) -> Completable {
        rxObserveSingleEvent("state/discard", decoding: { snapshot -> [String: String] in
           try (snapshot.value as? [String: String]).unwrap()
       }).flatMapCompletable { cards in
           let cardKey = cards.keys.sorted().max()!
           let card = cards[cardKey]
           return rxSetValue("state/discard/\(cardKey)", encoding: { nil })
               .andThen(rxSetValue("state/players/\(player)/hand/\(childByAutoIdKey())", encoding: { card }))
        }
    }
    
    // MARK: - inPlay
    
    func equip(player: String, card: String) -> Completable {
        rxObserveSingleEvent("state/players/\(player)/hand", decoding: { snapshot -> [String: String] in
            try (snapshot.value as? [String: String]).unwrap()
        }).flatMapCompletable { cards in
            let cardKey = cards.first(where: { $0.value == card })!.key
            return rxSetValue("state/players/\(player)/hand/\(cardKey)", encoding: { nil })
                .andThen(rxSetValue("state/players/\(player)/inPlay/\(childByAutoIdKey())", encoding: { card }))
        }
    }
    
    func handicap(player: String, card: String, other: String) -> Completable {
        rxObserveSingleEvent("state/players/\(player)/hand", decoding: { snapshot -> [String: String] in
            try (snapshot.value as? [String: String]).unwrap()
        }).flatMapCompletable { cards in
            let cardKey = cards.first(where: { $0.value == card })!.key
            return rxSetValue("state/players/\(player)/hand/\(cardKey)", encoding: { nil })
                .andThen(rxSetValue("state/players/\(other)/inPlay/\(childByAutoIdKey())", encoding: { card }))
        }
    }
    
    func passInPlay(player: String, card: String, other: String) -> Completable {
        rxObserveSingleEvent("state/players/\(player)/inPlay", decoding: { snapshot -> [String: String] in
            try (snapshot.value as? [String: String]).unwrap()
        }).flatMapCompletable { cards in
            let cardKey = cards.first(where: { $0.value == card })!.key
            return rxSetValue("state/players/\(player)/inPlay/\(cardKey)", encoding: { nil })
                .andThen(rxSetValue("state/players/\(other)/inPlay/\(childByAutoIdKey())", encoding: { card }))
        }
    }
    
    // MARK: - Discard
    
    func discardHand(player: String, card: String) -> Completable {
        rxObserveSingleEvent("state/players/\(player)/hand", decoding: { snapshot -> [String: String] in
            try (snapshot.value as? [String: String]).unwrap()
        }).flatMapCompletable { cards in
            let cardKey = cards.first(where: { $0.value == card })!.key
            return rxSetValue("state/players/\(player)/hand/\(cardKey)", encoding: { nil })
                .andThen(rxSetValue("state/discard/\(childByAutoIdKey())", encoding: { card }))
        }
    }
    
    func play(player: String, card: String) -> Completable {
        rxObserveSingleEvent("state/players/\(player)/hand", decoding: { snapshot -> [String: String] in
            try (snapshot.value as? [String: String]).unwrap()
        }).flatMapCompletable { cards in
            let cardKey = cards.first(where: { $0.value == card })!.key
            return rxSetValue("state/players/\(player)/hand/\(cardKey)", encoding: { nil })
                .andThen(rxSetValue("state/discard/\(childByAutoIdKey())", encoding: { card }))
        }
    }
    
    func discardInPlay(player: String, card: String) -> Completable {
        rxObserveSingleEvent("state/players/\(player)/inPlay", decoding: { snapshot -> [String: String] in
            try (snapshot.value as? [String: String]).unwrap()
        }).flatMapCompletable { cards in
            let cardKey = cards.first(where: { $0.value == card })!.key
            return rxSetValue("state/players/\(player)/inPlay/\(cardKey)", encoding: { nil })
                .andThen(rxSetValue("state/discard/\(childByAutoIdKey())", encoding: { card }))
        }
    }
    
    // MARK: - Store
    
    func deckToStore() -> Completable {
        resetDeckIfNeeded()
            .andThen(rxObserveSingleEvent("state/deck", decoding: { snapshot -> [String: String] in
                try (snapshot.value as? [String: String]).unwrap()
            }).flatMapCompletable({ cards in
                let cardKey = cards.keys.sorted().min()!
                let card = cards[cardKey]
                return rxSetValue("state/deck/\(cardKey)", encoding: { nil })
                    .andThen(rxSetValue("state/store/\(childByAutoIdKey())", encoding: { card }))
            }))
    }
    
    // MARK: - Flip
    
    func flipDeck() -> Completable {
        resetDeckIfNeeded()
            .andThen(rxObserveSingleEvent("state/deck", decoding: { snapshot -> [String: String] in
                try (snapshot.value as? [String: String]).unwrap()
            }).flatMapCompletable({ cards in
                let cardKey = cards.keys.sorted().min()!
                let card = cards[cardKey]
                return rxSetValue("state/deck/\(cardKey)", encoding: { nil })
                    .andThen(rxSetValue("state/discard/\(childByAutoIdKey())", encoding: { card }))
            }))
    }
    
    // MARK: - Hit
    
    func addHit(_ hit: GHit) -> Completable {
        let dto = HitDto(name: hit.name,
                         players: hit.players,
                         abilities: hit.abilities,
                         cancelable: hit.cancelable,
                         targets: hit.targets)
        return rxSetValue("state/hit", encoding: { try DictionaryEncoder().encode(dto) })
    }
    
    func removeHit(_ player: String) -> Completable {
        rxObserveSingleEvent("state/hit", decoding: { snapshot -> [String: Any]? in
            snapshot.value as? [String: Any]
        }).flatMapCompletable { hit in
            guard let hit = hit,
                  var hitPlayers = hit["players"] as? [String],
                  let index = hitPlayers.firstIndex(of: player) else {
                return Completable.empty()
            }
            
            var completables: [Completable] = []
            
            hitPlayers.remove(at: index)
            
            if var hitTargets = hit["targets"] as? [String],
               index < hitTargets.count {
                hitTargets.remove(at: index)
                completables.append(rxSetValue("state/hit/targets", encoding: { hitTargets }))
            }
            
            if hitPlayers.isEmpty {
                completables.append(rxSetValue("state/hit", encoding: { nil }))
            } else {
                completables.append(rxSetValue("state/hit/players", encoding: { hitPlayers }))
            }
            
            return Completable.concat(completables)
        }
    }
    
    func decrementHitCancelable() -> Completable {
        rxObserveSingleEvent("state/hit/cancelable", decoding: { snapshot -> Int in
            try (snapshot.value as? Int).unwrap()
        }).flatMapCompletable { cancelable in
            rxSetValue("state/hit/cancelable", encoding: { cancelable - 1 })
        }
    }
}

private extension DatabaseReferenceProtocol {
    
    func resetDeckIfNeeded() -> Completable {
        let minDeck = 2
        return rxObserveSingleEvent("state/deck", decoding: { snapshot -> [String: String] in
            try (snapshot.value as? [String: String]).unwrap()
        }).flatMapCompletable { deck in
            if deck.count > minDeck {
                // Do nothing
                return Completable.empty()
            }
            
            // Reset deck
            let minDiscard = 2
            return rxObserveSingleEvent("state/discard", decoding: { snapshot -> [String: String] in
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
                    completables.append(rxSetValue("state/discard/\(key)", encoding: { nil }))
                    completables.append(rxSetValue("state/deck/\(childByAutoIdKey())", encoding: { value }))
                }
                return Completable.concat(completables)
            }
        }
    }
}
