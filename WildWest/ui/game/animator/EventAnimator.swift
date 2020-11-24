//
//  EventAnimator.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 13/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import CardGameEngine

enum CardArea: Hashable {
    case deck
    case discard
    case store
    case hand(String)
    case inPlay(String)
}

protocol EventAnimatorProtocol {
    func animate(on event: GEvent, in state: StateProtocol)
}

class EventAnimator: EventAnimatorProtocol {
    
    private let eventMatcher: EventMatcherProtocol
    private let renderer: AnimationRendererProtocol
    private let sfxPlayer: SFXPlayerProtocol
    
    init(eventMatcher: EventMatcherProtocol, 
         renderer: AnimationRendererProtocol,
         sfxPlayer: SFXPlayerProtocol) {
        self.eventMatcher = eventMatcher
        self.renderer = renderer
        self.sfxPlayer = sfxPlayer
    }
    
    func animate(on event: GEvent, in state: StateProtocol) {
        
        if let gfx = Self.gfx[event.hashValue] {
            let animation = gfx.animateFunc(event, state)
            renderer.execute(animation, duration: eventMatcher.waitDuration(event))
        }
        
        if let sfx = Self.sfx[event.hashValue] {
            sfxPlayer.playSound(named: sfx)
        }
        
        /*
        switch event {
        case let .revealHand(player, card):
            guard let card = state.players[player]?.hand.first(where: { $0.identifier == card }) else {
                fatalError("Illegal state")
            }
            animateRevealCard(sourceImage: UIImage(named: card.name),
                              from: .hand(player), 
                              to: .hand(player), 
                              duration: duration)
            
        case let .discardInPlay(player, card):
            guard let card = state.players[player]?.inPlay.first(where: { $0.identifier == card }) else {
                fatalError("Illegal state")
            }
            animateMoveCard(sourceImage: UIImage(named: card.name),
                            targetImage: state.topDiscardImage,
                            from: .inPlay(player),
                            to: .discard,
                            duration: duration)
            
        case let .drawHand(player, other, _):
            animateMoveCard(from: .hand(other),
                            to: .hand(player), 
                            duration: duration)
            
        case let .drawInPlay(player, other, card):
            guard let card = state.players[other]?.inPlay.first(where: { $0.identifier == card }) else {
                fatalError("Illegal state")
            }
            animateMoveCard(sourceImage: UIImage(named: card.name),
                            from: .inPlay(other),
                            to: .hand(player), 
                            duration: duration)
            
        case let .putInPlayOther(player, card, other):
            guard let card = state.players[player]?.hand.first(where: { $0.identifier == card }) else {
                fatalError("Illegal state")
            }
            animateMoveCard(sourceImage: UIImage(named: card.name),
                            from: .hand(player),
                            to: .inPlay(other), 
                            duration: duration)
            
        case let .passInPlayOther(player, card, other):
            guard let card = state.players[player]?.inPlay.first(where: { $0.identifier == card }) else {
                fatalError("Illegal state")
            }
            animateMoveCard(sourceImage: UIImage(named: card.name),
                            from: .inPlay(player),
                            to: .inPlay(other), 
                            duration: duration)
            
        case .revealDeck:
            guard let card = state.deck.first else {
                fatalError("Illegal state")
            }
            animateRevealCard(sourceImage: UIImage(named: card.name),
                              targetImage: state.topDiscardImage,
                              from: .deck,
                              to: .discard,
                              duration: duration)
            
        case .deckToStore:
            guard let card = state.deck.first else {
                fatalError("Illegal state")
            }
            
            let sourceImage = state.storeView == nil ? UIImage(named: card.name) : #imageLiteral(resourceName: "01_back")  
            animateRevealCard(sourceImage: sourceImage,
                              from: .deck,
                              to: .store,
                              duration: duration)
            
        case .storeToDeck:
            animateRevealCard(from: .store,
                              to: .deck,
                              duration: duration)
            
        case let .drawStore(player, card):
            guard let card = state.store.first(where: { $0.identifier == card }) else {
                fatalError("Illegal state")
            }
            let sourceImage = state.storeView == nil ? UIImage(named: card.name) : #imageLiteral(resourceName: "01_back")
            animateMoveCard(sourceImage: sourceImage,
                            from: .store,
                            to: .hand(player), 
                            duration: duration)
            
        case .setTurn,
             .setPhase, 
             .looseHealth,
             .gainHealth, 
             .eliminate:
            
        }
         */
    }
}

private typealias EventAnimateFunc = (GEvent, StateProtocol) -> EventAnimation

private struct EventDesc {
    let id: String
    let animateFunc: EventAnimateFunc
}

private extension EventAnimator {
    
    static let gfx: [String: EventDesc] = [
        drawDeck(),
        drawDiscard(),
        discardHand(),
        putInPlay()
    ]
    .toDictionary(with: { $0.id })
    
    static let sfx: [String: String] = [
        "drawDeck": "Slide Closed-SoundBible.com-1521580537",
        "drawDiscard": "Slide Closed-SoundBible.com-1521580537",
        "putInPlay": "Shotgun-SoundBible.com-862990674"
    ]
    
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
            guard let card = state.discard.first else {
                fatalError("Illegal state")
            }
            return .move(sourceName: card.name, targetName: nil, source: .discard, target: .hand(player))
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
}
