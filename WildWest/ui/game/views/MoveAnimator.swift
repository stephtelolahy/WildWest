//
//  MoveAnimator.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 13/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

protocol MoveAnimatorProtocol {
    func animate(move: GameMove, in state: GameStateProtocol)
}

class MoveAnimator: MoveAnimatorProtocol {
    
    private unowned var viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func animate(move: GameMove, in state: GameStateProtocol) {
        switch move.name {
        case .play,
             .discard,
             .discardExcessCards,
             .bangWithMissed:
            
            guard let actor = state.player(move.actorId),
                let card = actor.handCard(move.cardId) else {
                    fatalError("Card not found")
            }
            
            animateCard(UIImage(named: card.imageName),
                        from: .player(move.actorId),
                        to: .discard)
            
        default:
            break
            // TODO: implement animation
        }
    }
}

enum CardPosition: Hashable {
    case player(String)
    case deck
    case discard
}

private extension MoveAnimator {
    
    func animateCard(_ image: UIImage?, from source: CardPosition, to target: CardPosition) {
        guard let achorView = viewController.view else {
            return
        }
        
        let sourcePosition = CGPoint(x: 100, y: achorView.bounds.height / 2)
        let targetPosition = CGPoint(x: achorView.bounds.width / 2, y: achorView.bounds.height / 2)
        
        viewController.animateCard(image: image,
                                   from: sourcePosition,
                                   to: targetPosition,
                                   duration: UserPreferences.shared.updateDelay * 0.6)
    }
}
