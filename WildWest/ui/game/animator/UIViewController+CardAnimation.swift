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
                     size: CGSize,
                     from source: CGPoint,
                     to target: CGPoint,
                     duration: Double,
                     completion: ((Bool) -> Void)? = nil) {
        let cardView = UIImageView(frame: CGRect(origin: source, size: size))
        cardView.image = image
        view.addSubview(cardView)
        
        cardView.animate(from: source, to: target, duration: duration, completion: { finished in
            cardView.removeFromSuperview()
            completion?(finished)
        })
    }
}

private extension UIView {
    func animate(from source: CGPoint,
                 to target: CGPoint,
                 duration: Double,
                 completion: ((Bool) -> Void)?) {
        
        self.center = source
        
        let animationOptions: UIView.AnimationOptions = .curveEaseOut
        let keyframeAnimationOptions: UIView.KeyframeAnimationOptions =
            UIView.KeyframeAnimationOptions(rawValue: animationOptions.rawValue)
        
        UIView.animateKeyframes(withDuration: duration,
                                delay: 0,
                                options: keyframeAnimationOptions,
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0) {
                                        self.center = target
                                    }
                                },
                                completion: completion)
    }
}
