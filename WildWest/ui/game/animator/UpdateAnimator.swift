//
//  UpdateAnimator.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 13/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable cyclomatic_complexity
// swiftlint:disable function_body_length

import UIKit

enum CardPlace: Hashable {
    case deck
    case discard
    case hand(String)
    case inPlay(String)
}

protocol UpdateAnimatorProtocol {
    func animate(_ update: GameUpdate, in state: GameStateProtocol)
}

class UpdateAnimator: UpdateAnimatorProtocol {
    
    private unowned let viewController: UIViewController
    private let cardPositions: [CardPlace: CGPoint]
    private let cardSize: CGSize
    private let updateDelay: TimeInterval
    
    init(viewController: UIViewController,
         cardPositions: [CardPlace: CGPoint],
         cardSize: CGSize,
         updateDelay: TimeInterval) {
        self.viewController = viewController
        self.cardPositions = cardPositions
        self.cardSize = cardSize
        self.updateDelay = updateDelay
    }
    
    func animate(_ update: GameUpdate, in state: GameStateProtocol) {
        switch update {
        case let .playerPullFromDeck(playerId):
            animateMoveCard(from: .deck, to: .hand(playerId))
            
        case let .playerDiscardHand(playerId, cardId):
            guard let card = state.allPlayers.first(where: { $0.identifier == playerId })?.handCard(cardId)  else {
                fatalError("Illegal state")
            }
            animateMoveCard(sourceImage: UIImage(named: card.imageName),
                            targetImage: state.topDiscardImage,
                            from: .hand(playerId),
                            to: .discard)
            
        case let .playerPutInPlay(playerId, cardId):
            guard let card = state.player(playerId)?.handCard(cardId) else {
                fatalError("Illegal state")
            }
            animateMoveCard(sourceImage: UIImage(named: card.imageName),
                            from: .hand(playerId),
                            to: .inPlay(playerId))
            
        case let .playerRevealHandCard(playerId, cardId):
            guard let card = state.player(playerId)?.handCard(cardId) else {
                fatalError("Illegal state")
            }
            animateRevealCard(image: UIImage(named: card.imageName),
                              at: .hand(playerId))
            
        case let .playerDiscardInPlay(playerId, cardId):
            guard let card = state.allPlayers.first(where: { $0.identifier == playerId })?.inPlayCard(cardId) else {
                fatalError("Illegal state")
            }
            animateMoveCard(sourceImage: UIImage(named: card.imageName),
                            targetImage: state.topDiscardImage,
                            from: .inPlay(playerId),
                            to: .discard)
            
        case let .playerPullFromOtherHand(playerId, otherId, _):
            animateMoveCard(from: .hand(otherId),
                            to: .hand(playerId))
            
        case let .playerPullFromOtherInPlay(playerId, otherId, cardId):
            guard let card = state.allPlayers.first(where: { $0.identifier == otherId })?.inPlayCard(cardId) else {
                fatalError("Illegal state")
            }
            animateMoveCard(sourceImage: UIImage(named: card.imageName),
                            from: .inPlay(otherId),
                            to: .hand(playerId))
            
        case let .playerPutInPlayOfOther(playerId, otherId, cardId):
            guard let card = state.player(playerId)?.handCard(cardId) else {
                fatalError("Illegal state")
            }
            animateMoveCard(sourceImage: UIImage(named: card.imageName),
                            from: .hand(playerId),
                            to: .inPlay(otherId))
            
        case let .playerPassInPlayOfOther(playerId, otherId, cardId):
            guard let card = state.player(playerId)?.inPlayCard(cardId) else {
                fatalError("Illegal state")
            }
            animateMoveCard(sourceImage: UIImage(named: card.imageName),
                            from: .inPlay(playerId),
                            to: .inPlay(otherId))
            
        case let .playerPullFromGeneralStore(playerId, cardId):
            guard let card = state.generalStore.first(where: { $0.identifier == cardId }) else {
                fatalError("Illegal state")
            }
            animateMoveCard(sourceImage: UIImage(named: card.imageName),
                            from: .deck,
                            to: .hand(playerId))
            
        case .flipOverFirstDeckCard:
            guard let card = state.deck.first else {
                fatalError("Illegal state")
            }
            animateRevealThenMoveCard(sourceImage: UIImage(named: card.imageName),
                                      targetImage: state.topDiscardImage,
                                      from: .deck,
                                      to: .discard)
            
        default:
            break
        }
    }
}

private extension UpdateAnimator {
    
    func animateMoveCard(sourceImage: UIImage? = #imageLiteral(resourceName: "01_back"),
                         targetImage: UIImage? = nil,
                         from source: CardPlace,
                         to target: CardPlace) {
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
                           at source: CardPlace) {
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
                                   from source: CardPlace,
                                   to target: CardPlace) {
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
