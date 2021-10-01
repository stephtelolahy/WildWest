//
//  GDatabaseUpdater.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 14/11/2020.
//
// swiftlint:disable cyclomatic_complexity
// swiftlint:disable function_body_length

public protocol GDatabaseUpdaterProtocol {
    func execute(_ event: GEvent, in state: StateProtocol) -> StateProtocol?
}

public class GDatabaseUpdater: GDatabaseUpdaterProtocol {
    
    public init() {
    }
    
    public func execute(_ event: GEvent, in state: StateProtocol) -> StateProtocol? {
        switch event {
        case let .run(move):
            return state.run(move)
            
        case let .setTurn(player):
            return state.setTurn(player)
            
        case let .setPhase(value):
            return state.setPhase(value)
            
        case let .gainHealth(player):
            return state.gainHealth(player)
            
        case let .looseHealth(player, _):
            return state.looseHealth(player)
            
        case let .eliminate(player, _):
            return state.eliminate(player)
            
        case let .drawDeck(player):
            return state.drawDeck(player)
            
        case let .drawDeckChoosing(player, card):
            return state.drawDeckChoosing(player: player, card: card)
            
        case let .drawDeckFlipping(player):
            return state.drawDeckFlipping(player)
            
        case let .drawHand(player, other, card):
            return state.drawHand(player: player, other: other, card: card)
            
        case let .drawInPlay(player, other, card):
            return state.drawInPlay(player: player, other: other, card: card)
            
        case let .drawStore(player, card):
            return state.drawStore(player: player, card: card)
            
        case let .drawDiscard(player):
            return state.drawDiscard(player)
            
        case let .equip(player, card):
            return state.equip(player: player, card: card)
            
        case let .handicap(player, card, other):
            return state.handicap(player: player, card: card, other: other)
            
        case let .passInPlay(player, card, other):
            return state.passInPlay(player: player, card: card, other: other)
            
        case let .discardHand(player, card):
            return state.discardHand(player: player, card: card)
            
        case let .play(player, card):
            return state.play(player: player, card: card)
            
        case let .discardInPlay(player, card):
            return state.discardInPlay(player: player, card: card)
            
        case .deckToStore:
            return state.deckToStore()
            
        case .flipDeck:
            return state.flipDeck()
            
        case let .addHit(hit):
            return state.addHit(hit)
            
        case let .removeHit(player):
            return state.removeHit(player)
            
        case .decrementHitCancelable:
            return state.decrementHitCancelable()
            
        case let .gameover(winner):
            return state.gameover(winner)
        
        default:
            return nil
        }
    }
}

private extension StateProtocol {
    
    // MARK: - Flags
    
    func run(_ move: GMove) -> StateProtocol {
        let state = GState.copy(self)
        state.played.append(move.ability)
        state.history.append(move)
        return state
    }
    
    func setTurn(_ player: String) -> StateProtocol {
        let state = GState.copy(self)
        state.turn = player
        state.played.removeAll()
        return state
    }
    
    func setPhase(_ phase: Int) -> StateProtocol {
        let state = GState.copy(self)
        state.phase = phase
        return state
    }
    
    func gameover(_ winner: Role) -> StateProtocol {
        let state = GState.copy(self)
        state.winner = winner
        return state
    }
    
    // MARK: - Health
    
    func gainHealth(_ player: String) -> StateProtocol {
        let state = GState.copy(self)
        state.mutablePlayer(player).health += 1
        return state
    }
    
    func looseHealth(_ player: String) -> StateProtocol {
        let state = GState.copy(self)
        state.mutablePlayer(player).health -= 1
        return state
    }
    
    func eliminate(_ player: String) -> StateProtocol {
        let state = GState.copy(self)
        state.playOrder.removeAll(where: { $0 == player })
        if let hit = state.hit as? GHit {
            state.hit = hit.removingAll(player)
        }
        state.mutablePlayer(player).health = 0
        return state
    }
    
    // MARK: - Draw
    
    func drawDeck(_ player: String) -> StateProtocol {
        let state = GState.copy(self)
        state.resetDeckIfNeeded()
        let cardObject = state.deck.removeFirst()
        state.mutablePlayer(player).hand.append(cardObject)
        return state
    }
    
    func drawDeckChoosing(player: String, card: String) -> StateProtocol {
        let state = GState.copy(self)
        guard let index = state.deck.firstIndex(where: { $0.identifier == card }) else {
            fatalError("Card \(card) not found")
        }
        let cardObject = state.deck.remove(at: index)
        state.mutablePlayer(player).hand.append(cardObject)
        return state
    }
    
    func drawDeckFlipping(_ player: String) -> StateProtocol {
        let state = GState.copy(self)
        state.resetDeckIfNeeded()
        let cardObject = state.deck.removeFirst()
        state.mutablePlayer(player).hand.append(cardObject)
        return state
    }
    
    func drawHand(player: String, other: String, card: String) -> StateProtocol {
        let state = GState.copy(self)
        let otherObject = state.mutablePlayer(other)
        guard let index = otherObject.hand.firstIndex(where: { $0.identifier == card }) else {
            fatalError("Card \(card) not found")
        }
        let cardObject = otherObject.hand.remove(at: index)
        state.mutablePlayer(player).hand.append(cardObject)
        return state
    }
    
    func drawInPlay(player: String, other: String, card: String) -> StateProtocol {
        let state = GState.copy(self)
        let otherObject = state.mutablePlayer(other)
        guard let index = otherObject.inPlay.firstIndex(where: { $0.identifier == card }) else {
            fatalError("Card \(card) not found")
        }
        let cardObject = otherObject.inPlay.remove(at: index)
        state.mutablePlayer(player).hand.append(cardObject)
        return state
    }
    
    func drawStore(player: String, card: String) -> StateProtocol {
        let state = GState.copy(self)
        guard let index = state.store.firstIndex(where: { $0.identifier == card }) else {
            fatalError("Card \(card) not found")
        }
        let cardObject = state.store.remove(at: index)
        state.mutablePlayer(player).hand.append(cardObject)
        return state
    }
    
    func drawDiscard(_ player: String) -> StateProtocol {
        let state = GState.copy(self)
        let cardObject = state.discard.removeFirst()
        state.mutablePlayer(player).hand.append(cardObject)
        return state
    }
    
    // MARK: - inPlay
    
    func equip(player: String, card: String) -> StateProtocol {
        let state = GState.copy(self)
        let playerObject = state.mutablePlayer(player)
        guard let index = playerObject.hand.firstIndex(where: { $0.identifier == card }) else {
            fatalError("Card \(card) not found")
        }
        let cardObject = playerObject.hand.remove(at: index)
        state.mutablePlayer(player).inPlay.append(cardObject)
        return state
    }
    
    func handicap(player: String, card: String, other: String) -> StateProtocol {
        let state = GState.copy(self)
        let playerObject = state.mutablePlayer(player)
        guard let index = playerObject.hand.firstIndex(where: { $0.identifier == card }) else {
            fatalError("Card \(card) not found")
        }
        let cardObject = playerObject.hand.remove(at: index)
        state.mutablePlayer(other).inPlay.append(cardObject)
        return state
    }
    
    func passInPlay(player: String, card: String, other: String) -> StateProtocol {
        let state = GState.copy(self)
        let playerObject = state.mutablePlayer(player)
        guard let index = playerObject.inPlay.firstIndex(where: { $0.identifier == card }) else {
            fatalError("Card \(card) not found")
        }
        let cardObject = playerObject.inPlay.remove(at: index)
        state.mutablePlayer(other).inPlay.append(cardObject)
        return state
    }
    
    // MARK: - Discard
    
    func discardHand(player: String, card: String) -> StateProtocol {
        let state = GState.copy(self)
        let playerObject = state.mutablePlayer(player)
        guard let index = playerObject.hand.firstIndex(where: { $0.identifier == card }) else {
            fatalError("Card \(card) not found")
        }
        let cardObject = playerObject.hand.remove(at: index)
        state.discard.insert(cardObject, at: 0)
        return state
    }
    
    func play(player: String, card: String) -> StateProtocol {
        let state = GState.copy(self)
        let playerObject = state.mutablePlayer(player)
        guard let index = playerObject.hand.firstIndex(where: { $0.identifier == card }) else {
            fatalError("Card \(card) not found")
        }
        let cardObject = playerObject.hand.remove(at: index)
        state.discard.insert(cardObject, at: 0)
        return state
    }
    
    func discardInPlay(player: String, card: String) -> StateProtocol {
        let state = GState.copy(self)
        let playerObject = state.mutablePlayer(player)
        guard let index = playerObject.inPlay.firstIndex(where: { $0.identifier == card }) else {
            fatalError("Card \(card) not found")
        }
        let cardObject = playerObject.inPlay.remove(at: index)
        state.discard.insert(cardObject, at: 0)
        return state
    }
    
    // MARK: - Store
    
    func deckToStore() -> StateProtocol {
        let state = GState.copy(self)
        state.resetDeckIfNeeded()
        let cardObject = state.deck.removeFirst()
        state.store.append(cardObject)
        return state
    }
    
    // MARK: - Flip
    
    func flipDeck() -> StateProtocol {
        let state = GState.copy(self)
        state.resetDeckIfNeeded()
        let cardObject = state.deck.removeFirst()
        state.discard.insert(cardObject, at: 0)
        return state
    }
    
    // MARK: - Hit
    
    func addHit(_ hit: GHit) -> StateProtocol {
        let state = GState.copy(self)
        
        guard state.hit == nil else {
            return self
        }
        
        state.hit = hit
        return state
    }
    
    func removeHit(_ player: String) -> StateProtocol? {
        let state = GState.copy(self)
        
        guard let hit = state.hit as? GHit else {
            return self
        }
        
        state.hit = hit.removing(player)
        return state
    }
    
    func decrementHitCancelable() -> StateProtocol {
        let state = GState.copy(self)
        
        guard let hit = state.hit as? GHit else {
            fatalError("hit not found")
        }
        
        state.hit = hit.decrementingCancelable()
        return state
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

private extension GHit {
    
    func removingAll(_ player: String) -> GHit? {
        var hit = self
        hit.players.removeAll(where: { $0 == player })
        
        if hit.players.isEmpty {
            return nil
        } else {
            return hit
        }
    }
    
    func removing(_ player: String) -> GHit? {
        var hit = self
        guard let index = hit.players.firstIndex(of: player) else {
            return self
        }
        
        hit.players.remove(at: index)
        
        if index < hit.targets.count {
            hit.targets.remove(at: index)
        }
        
        if hit.players.isEmpty {
            return nil
        } else {
            return hit
        }
    }
    
    func decrementingCancelable() -> GHit? {
        var hit = self
        hit.cancelable -= 1
        if hit.cancelable == 0 {
            return nil
        } else {
            return hit
        }
    }
}
