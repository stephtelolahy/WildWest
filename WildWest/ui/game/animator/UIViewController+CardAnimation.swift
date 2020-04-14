//
//  UIViewController+CardAnimation.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 13/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable function_parameter_count

import UIKit

extension UIViewController {
    func animateCard(sourceImage: UIImage?,
                     targetImage: UIImage?,
                     size: CGSize,
                     from source: CGPoint,
                     to target: CGPoint,
                     duration: Double,
                     completion: ((Bool) -> Void)? = nil) {
        
        let targetFrame = CGRect(x: target.x - size.width / 2,
                                 y: target.y - size.height / 2,
                                 width: size.width,
                                 height: size.height)
        let targetView = UIImageView(frame: targetFrame)
        targetView.image = targetImage
        view.addSubview(targetView)
        
        let sourceFrame = CGRect(x: source.x - size.width / 2,
                                 y: source.y - size.height / 2,
                                 width: size.width,
                                 height: size.height)
        let sourceView = UIImageView(frame: sourceFrame)
        sourceView.image = sourceImage
        view.addSubview(sourceView)
        
        sourceView.animate(to: target, duration: duration, completion: { finished in
            sourceView.removeFromSuperview()
            targetView.removeFromSuperview()
            completion?(finished)
        })
    }
}

private extension UIView {
    func animate(to target: CGPoint,
                 duration: Double,
                 completion: ((Bool) -> Void)?) {
        
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
