//
//  EventAnimator.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 13/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable function_body_length
// swiftlint:disable cyclomatic_complexity

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
}

class EventAnimator: EventAnimatorProtocol {
    
    private unowned let viewController: UIViewController
    private let cardPositions: [CardArea: CGPoint]
    private let cardSize: CGSize
    private let updateDelay: TimeInterval
    
    init(viewController: UIViewController,
         cardPositions: [CardArea: CGPoint],
         cardSize: CGSize,
         updateDelay: TimeInterval) {
        self.viewController = viewController
        self.cardPositions = cardPositions
        self.cardSize = cardSize
        self.updateDelay = updateDelay
    }
    
    func animate(on event: GEvent, in state: StateProtocol) {
        
        switch event {
        case let .drawDeck(player):
            animateMoveCard(from: .deck, to: .hand(player))
            
        case let .drawDiscard(player):
            guard let card = state.discard.first else {
                fatalError("Illegal state")
            }
            animateMoveCard(sourceImage: UIImage(named: card.name),
                            from: .discard,
                            to: .hand(player))
            
        case let .discardHand(player, card):
            guard let card = state.players[player]?.hand.first(where: { $0.identifier == card })  else {
                fatalError("Illegal state")
            }
            animateMoveCard(sourceImage: UIImage(named: card.name),
                            targetImage: state.topDiscardImage,
                            from: .hand(player),
                            to: .discard)
            
        case let .putInPlay(player, card):
            guard let card = state.players[player]?.hand.first(where: { $0.identifier == card }) else {
                fatalError("Illegal state")
            }
            animateMoveCard(sourceImage: UIImage(named: card.name),
                            from: .hand(player),
                            to: .inPlay(player))
            
        case let .revealHand(player, card):
            guard let card = state.players[player]?.hand.first(where: { $0.identifier == card }) else {
                fatalError("Illegal state")
            }
            animateRevealCard(image: UIImage(named: card.name),
                              at: .hand(player))
            
        case let .discardInPlay(player, card):
            guard let card = state.players[player]?.inPlay.first(where: { $0.identifier == card }) else {
                fatalError("Illegal state")
            }
            animateMoveCard(sourceImage: UIImage(named: card.name),
                            targetImage: state.topDiscardImage,
                            from: .inPlay(player),
                            to: .discard)
            
        case let .drawHand(player, other, _):
            animateMoveCard(from: .hand(other),
                            to: .hand(player))
            
        case let .drawInPlay(player, other, card):
            guard let card = state.players[other]?.inPlay.first(where: { $0.identifier == card }) else {
                fatalError("Illegal state")
            }
            animateMoveCard(sourceImage: UIImage(named: card.name),
                            from: .inPlay(other),
                            to: .hand(player))
            
        case let .putInPlayOther(player, card, other):
            guard let card = state.players[player]?.hand.first(where: { $0.identifier == card }) else {
                fatalError("Illegal state")
            }
            animateMoveCard(sourceImage: UIImage(named: card.name),
                            from: .hand(player),
                            to: .inPlay(other))
            
        case let .passInPlayOther(player, card, other):
            guard let card = state.players[player]?.inPlay.first(where: { $0.identifier == card }) else {
                fatalError("Illegal state")
            }
            animateMoveCard(sourceImage: UIImage(named: card.name),
                            from: .inPlay(player),
                            to: .inPlay(other))
            
        case let .drawStore(player, card):
            guard let card = state.store.first(where: { $0.identifier == card }) else {
                fatalError("Illegal state")
            }
            animateMoveCard(sourceImage: UIImage(named: card.name),
                            from: .store,
                            to: .hand(player))
            
        case .revealDeck:
            guard let card = state.deck.first else {
                fatalError("Illegal state")
            }
            animateRevealThenMoveCard(sourceImage: UIImage(named: card.name),
                                      targetImage: state.topDiscardImage,
                                      from: .deck,
                                      to: .discard)
            
        default:
            print("⚠️ Cannot animate \(event)")
        }
    }
}

private extension EventAnimator {
    
    func animateMoveCard(sourceImage: UIImage? = #imageLiteral(resourceName: "01_back"),
                         targetImage: UIImage? = nil,
                         from source: CardArea,
                         to target: CardArea) {
        guard let sourcePosition = cardPositions[source],
              let targetPosition = cardPositions[target] else {
            fatalError("Illegal state")
        }
        
        viewController.animateMoveCard(sourceImage: sourceImage,
                                       targetImage: targetImage,
                                       size: cardSize,
                                       from: sourcePosition,
                                       to: targetPosition,
                                       duration: updateDelay * 0.6)
    }
    
    func animateRevealCard(image: UIImage?,
                           at source: CardArea) {
        guard let position = cardPositions[source] else {
            fatalError("Illegal state")
        }
        
        viewController.animateRevealCard(image: image,
                                         size: cardSize,
                                         at: position,
                                         duration: updateDelay)
    }
    
    func animateRevealThenMoveCard(sourceImage: UIImage? = #imageLiteral(resourceName: "01_back"),
                                   targetImage: UIImage? = nil,
                                   from source: CardArea,
                                   to target: CardArea) {
        guard let sourcePosition = cardPositions[source],
              let targetPosition = cardPositions[target] else {
            fatalError("Illegal state")
        }
        
        viewController.animateRevealThenMoveCard(sourceImage: sourceImage,
                                                 targetImage: targetImage,
                                                 size: cardSize,
                                                 from: sourcePosition,
                                                 to: targetPosition,
                                                 duration: updateDelay)
    }
}
