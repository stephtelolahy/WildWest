//
//  EventAnimator.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 13/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable function_body_length
// swiftlint:disable cyclomatic_complexity
// swiftlint:disable type_body_length

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

private typealias AnimateFunc = (GEvent, GState) -> Void
private struct EventAnimation {
    let id: String
    let sfx: String
    let animateFunc: AnimateFunc
    #warning("TODO: take into account the event animation duration")
}

class EventAnimator: EventAnimatorProtocol {
    
    private unowned let viewController: UIViewController
    private let cardPositions: [CardArea: CGPoint]
    private let cardSize: CGSize
    private let updateDelay: TimeInterval
    private let eventMatcher: EventMatcherProtocol
    
    init(viewController: UIViewController,
         cardPositions: [CardArea: CGPoint],
         cardSize: CGSize,
         updateDelay: TimeInterval, 
         eventMatcher: EventMatcherProtocol) {
        self.viewController = viewController
        self.cardPositions = cardPositions
        self.cardSize = cardSize
        self.updateDelay = updateDelay
        self.eventMatcher = eventMatcher
    }
    
    func animate(on event: GEvent, in state: StateProtocol) {
        
        var duration = eventMatcher.waitDuration(event)
        guard duration > 0 else {
            return
        }
        duration *= updateDelay 
        
        switch event {
        case let .drawDeck(player):
            animateMoveCard(from: .deck,
                            to: .hand(player),
                            duration: duration)
            
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
    }
}

private extension EventAnimator {
    
    func animateMoveCard(sourceImage: UIImage? = #imageLiteral(resourceName: "01_back"),
                         targetImage: UIImage? = nil,
                         from source: CardArea,
                         to target: CardArea, 
                         duration: TimeInterval) {
        guard let sourcePosition = cardPositions[source],
              let targetPosition = cardPositions[target] else {
            fatalError("Illegal state")
        }
        
        viewController.animateMoveCard(sourceImage: sourceImage,
                                       targetImage: targetImage,
                                       size: cardSize,
                                       from: sourcePosition,
                                       to: targetPosition,
                                       duration: duration)
    }
    
    func animateRevealCard(sourceImage: UIImage? = #imageLiteral(resourceName: "01_back"),
                           targetImage: UIImage? = nil,
                           from source: CardArea,
                           to target: CardArea, 
                           duration: TimeInterval) {
        guard let sourcePosition = cardPositions[source],
              let targetPosition = cardPositions[target] else {
            fatalError("Illegal state")
        }
        
        viewController.animateRevealCard(sourceImage: sourceImage,
                                         targetImage: targetImage,
                                         size: cardSize,
                                         from: sourcePosition,
                                         to: targetPosition,
                                         duration: duration)
    }
}
