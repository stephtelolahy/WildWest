//
//  UpdateAnimator.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 13/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

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
    
    private unowned var viewController: UIViewController
    private let cardPositions: [CardPlace: CGPoint]
    private let cardSize: CGSize
    
    init(viewController: UIViewController,
         cardPositions: [CardPlace: CGPoint],
         cardSize: CGSize) {
        self.viewController = viewController
        self.cardPositions = cardPositions
        self.cardSize = cardSize
    }
    
    // swiftlint:disable cyclomatic_complexity
    // swiftlint:disable function_body_length
    // swiftlint:disable todo
    func animate(_ update: GameUpdate, in state: GameStateProtocol) {
        // TODO: use current didscard pile as placeholder target card during animation
        switch update {
        case let .setTurn(turn):
            break // TODO: implement
            
        case let .setChallenge(challenge):
            break // TODO: implement
            
        case let .playerGainHealth(playerId, points):
            break // TODO: implement
            
        case let .playerLooseHealth(playerId, points, source):
            break // TODO: implement
            
        case let .playerPullFromDeck(playerId, cardsCount):
            animateCard(#imageLiteral(resourceName: "01_back"), from: .deck, to: .hand(playerId))
            
        case let .playerDiscardHand(playerId, cardId):
            guard let card = state.allPlayers.first(where: { $0.identifier == playerId })?.handCard(cardId),
                let image = UIImage(named: card.imageName) else {
                    fatalError("Illegal state")
            }
            animateCard(image, from: .hand(playerId), to: .discard)
            
        case let .playerPutInPlay(playerId, cardId):
            guard let card = state.player(playerId)?.handCard(cardId),
                let image = UIImage(named: card.imageName) else {
                    fatalError("Illegal state")
            }
            animateCard(image, from: .hand(playerId), to: .inPlay(playerId))
            
        case let .playerDiscardInPlay(playerId, cardId):
            guard let card = state.allPlayers.first(where: { $0.identifier == playerId })?.inPlayCard(cardId),
                let image = UIImage(named: card.imageName) else {
                    fatalError("Illegal state")
            }
            animateCard(image, from: .inPlay(playerId), to: .discard)
            
        case let .playerPullFromOtherHand(playerId, otherId, _):
            animateCard(#imageLiteral(resourceName: "01_back"), from: .hand(otherId), to: .hand(playerId))
            
        case let .playerPullFromOtherInPlay(playerId, otherId, cardId):
            guard let card = state.player(otherId)?.inPlayCard(cardId),
                let image = UIImage(named: card.imageName) else {
                    fatalError("Illegal state")
            }
            animateCard(image, from: .inPlay(otherId), to: .hand(playerId))
            
        case let .playerPutInPlayOfOther(playerId, otherId, cardId):
            guard let card = state.player(playerId)?.handCard(cardId),
                let image = UIImage(named: card.imageName) else {
                    fatalError("Illegal state")
            }
            animateCard(image, from: .hand(playerId), to: .inPlay(otherId))
            
        case let .playerPassInPlayOfOther(playerId, otherId, cardId):
            guard let card = state.player(playerId)?.inPlayCard(cardId),
                let image = UIImage(named: card.imageName) else {
                    fatalError("Illegal state")
            }
            animateCard(image, from: .inPlay(playerId), to: .inPlay(otherId))
            
        case let .playerPullFromGeneralStore(playerId, cardId):
            guard let card = state.generalStore.first(where: { $0.identifier == cardId }),
                let image = UIImage(named: card.imageName) else {
                    fatalError("Illegal state")
            }
            animateCard(image, from: .deck, to: .hand(playerId))
            
        case let .setupGeneralStore(cardsCount):
            break // TODO: implement
            
        case .flipOverFirstDeckCard:
            guard let card = state.deck.first,
                let image = UIImage(named: card.imageName) else {
                    fatalError("Illegal state")
            }
            animateCard(image, from: .deck, to: .discard)
        }
    }
}

private extension UpdateAnimator {
    func animateCard(_ image: UIImage?, from source: CardPlace, to target: CardPlace) {
        guard let sourcePosition = cardPositions[source],
            let targetPosition = cardPositions[target] else {
                fatalError("Illegal state")
        }
        
        viewController.animateCard(image: image,
                                   size: cardSize,
                                   from: sourcePosition,
                                   to: targetPosition,
                                   duration: UserPreferences.shared.updateDelay * 0.6)
    }
}
