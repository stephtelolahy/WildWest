//
//  AnimationRenderer.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/11/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import CardGameEngine

protocol AnimationRendererProtocol {
    func execute(_ animation: EventAnimation, in state: StateProtocol) 
}

class AnimationRenderer: AnimationRendererProtocol {
    
    private weak var viewController: UIViewController?
    private let cardPositions: [CardArea: CGPoint]
    private let cardSize: CGSize
    private let cardBackImage: UIImage
    
    init(viewController: UIViewController,
         cardPositions: [CardArea: CGPoint],
         cardSize: CGSize, 
         cardBackImage: UIImage) {
        self.viewController = viewController
        self.cardPositions = cardPositions
        self.cardSize = cardSize
        self.cardBackImage = cardBackImage
    }
    
    func execute(_ animation: EventAnimation, in state: StateProtocol) {
        switch animation.type {
        case let .move(card, source, target):
            let sourceName = sourceImageName(for: card, in: state)
            let targetName = targetImageName(to: target, in: state)
            viewController?.animateMoveCard(sourceImage: UIImage.image(named: sourceName) ?? cardBackImage,
                                            targetImage: UIImage.image(named: targetName),
                                            size: cardSize,
                                            from: cardPositions[source]!,
                                            to: cardPositions[target]!,
                                            duration: animation.duration)
            
        case let .reveal(card, source, target):
            let sourceName = sourceImageName(for: card, in: state)
            let targetName = targetImageName(to: target, in: state)
            viewController?.animateRevealCard(sourceImage: UIImage.image(named: sourceName) ?? cardBackImage,
                                              targetImage: UIImage.image(named: targetName),
                                              size: cardSize,
                                              from: cardPositions[source]!,
                                              to: cardPositions[target]!,
                                              duration: animation.duration)
            
        case .dummy:
            break
        }
    }
    
    private func sourceImageName(for card: String?, in state: StateProtocol) -> String? {
        switch card {
        case StateCard.deck:
            return state.deck.first?.identifier
            
        case StateCard.discard:
            return state.discard.first?.identifier
            
        default:
            return card
        }
    }
    
    private func targetImageName(to target: CardArea, in state: StateProtocol) -> String? {
        if target == .discard {
            return state.discard.first?.identifier  
        } else {
            return nil
        }
    }
    
}

private extension UIImage {
    
    static func image(named card: String?) -> UIImage? {
        guard let cardName = card?.split(separator: "-").first else {
            return nil
        }
        return UIImage(named: String(cardName))!
    } 
}
