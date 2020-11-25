//
//  AnimationRenderer.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/11/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

protocol AnimationRendererProtocol {
    func execute(_ animation: EventAnimation, duration: TimeInterval) 
}

class AnimationRenderer: AnimationRendererProtocol {
    
    private weak var viewController: UIViewController?
    private let delay: TimeInterval
    private let cardPositions: [CardArea: CGPoint]
    private let cardSize: CGSize
    private let cardBackImage: UIImage
    
    init(viewController: UIViewController,
         delay: TimeInterval,
         cardPositions: [CardArea: CGPoint],
         cardSize: CGSize, 
         cardBackImage: UIImage) {
        self.viewController = viewController
        self.delay = delay
        self.cardPositions = cardPositions
        self.cardSize = cardSize
        self.cardBackImage = cardBackImage
    }
    
    func execute(_ animation: EventAnimation, duration: TimeInterval) {
        switch animation {
        case let .move(sourceImage, targetImage, source, target):
            viewController?.animateMoveCard(sourceImage: UIImage.image(named: sourceImage) ?? cardBackImage,
                                            targetImage: UIImage.image(named: targetImage),
                                            size: cardSize,
                                            from: cardPositions[source]!,
                                            to: cardPositions[target]!,
                                            duration: duration * delay)
            
        case let .reveal(sourceImage, targetImage, source, target):
            viewController?.animateRevealCard(sourceImage: UIImage.image(named: sourceImage) ?? cardBackImage,
                                              targetImage: UIImage.image(named: targetImage),
                                              size: cardSize,
                                              from: cardPositions[source]!,
                                              to: cardPositions[target]!,
                                              duration: duration * delay)
        }
    }
}

private extension UIImage {
    static func image(named imageName: String?) -> UIImage? {
        guard let sourceName = imageName else {
            return nil
        }
        return UIImage(named: sourceName)
    } 
}
