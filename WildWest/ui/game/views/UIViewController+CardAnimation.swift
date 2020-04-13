//
//  UIViewController+CardAnimation.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 13/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

extension UIViewController {
    func animateCard(image: UIImage?,
                     from source: CGPoint,
                     to target: CGPoint,
                     scale: CGFloat = 4.0,
                     duration: Double = 1.2,
                     completion: ((Bool) -> Void)? = nil) {
        let cardSize = CGSize(width: 64, height: 96)
        let cardView = UIImageView(frame: CGRect(origin: source, size: cardSize))
        cardView.image = image
        view.addSubview(cardView)
        
        cardView.animate(from: source, to: target, scale: scale, duration: duration, completion: { finished in
            cardView.removeFromSuperview()
            completion?(finished)
        })
    }
}

private extension UIView {
    func animate(from source: CGPoint,
                 to target: CGPoint,
                 scale: CGFloat,
                 duration: Double,
                 completion: ((Bool) -> Void)?) {
        
        self.center = source
        
        let middle = CGPoint(x: (source.x + target.x) / 2,
                             y: (source.y + target.y) / 2)
        
        UIView.animateKeyframes(withDuration: duration,
                                delay: 0,
                                options: .calculationModeCubic,
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2) {
                                        self.transform = CGAffineTransform(scaleX: scale, y: scale)
                                        self.center = middle
                                    }
                                    
                                    UIView.addKeyframe(withRelativeStartTime: 0.9, relativeDuration: 0.1) {
                                        self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                                        self.center = target
                                    }
                                    
        },
                                completion: completion)
    }
}
