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
        let duration = eventMatcher.waitDuration(event)
        guard duration > 0 else {
            return
        }
        
        guard let eventDesc = Self.all[event.hashValue] else {
            print("⚠️ No event description matching \(event)")
            return
        }
        
        if let animation = eventDesc.animateFunc(event, state) {
            renderer.execute(animation, duration: duration)
        }
        
        sfxPlayer.playSound(named: eventDesc.sfx)
        
        /*
        switch event {
        
            
        case let .drawDiscard(player):
            guard let card = state.discard.first else {
                fatalError("Illegal state")
            }
            animateMoveCard(sourceImage: UIImage(named: card.name),
                            from: .discard,
                            to: .hand(player), 
                            duration: duration)
            
        case let .discardHand(player, card):
            guard let card = state.players[player]?.hand.first(where: { $0.identifier == card })  else {
                fatalError("Illegal state")
            }
            animateMoveCard(sourceImage: UIImage(named: card.name),
                            targetImage: state.topDiscardImage,
                            from: .hand(player),
                            to: .discard, 
                            duration: duration)
            
        case let .putInPlay(player, card):
            guard let card = state.players[player]?.hand.first(where: { $0.identifier == card }) else {
                fatalError("Illegal state")
            }
            animateMoveCard(sourceImage: UIImage(named: card.name),
                            from: .hand(player),
                            to: .inPlay(player),
                            duration: duration)
            
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
            #warning("TODO: animate")
            
        default:
            fatalError("⚠️ Cannot animate \(event)")
        }
         */
    }
}

private typealias EventAnimateFunc = (GEvent, StateProtocol) -> EventAnimation?

private struct EventDesc {
    let id: String
    let sfx: String
    let animateFunc: EventAnimateFunc
}

private extension EventAnimator {
    
    static let all: [String: EventDesc] = [
        drawDeck()
    ]
    .toDictionary(with: { $0.id })
    
    static func drawDeck() -> EventDesc {
        EventDesc(id: "drawDeck", 
                  sfx: "Slide Closed-SoundBible.com-1521580537") { event, _ in
            guard case let .drawDeck(player) = event else {
                return nil
            }
            
            return .move(sourceName: nil,
                         targetName: nil, 
                         source: .deck, 
                         target: .hand(player))
        }
    }
}
