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
    
    func animateMoveCard(sourceImage: UIImage?,
                         targetImage: UIImage?,
                         size: CGSize,
                         from source: CGPoint,
                         to target: CGPoint,
                         duration: TimeInterval,
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
        
        sourceView.animateMove(to: target, duration: duration, completion: { finished in
            sourceView.removeFromSuperview()
            targetView.removeFromSuperview()
            completion?(finished)
        })
    }
    
    func animateRevealCard(image: UIImage?,
                           size: CGSize,
                           at position: CGPoint,
                           duration: TimeInterval,
                           completion: ((Bool) -> Void)? = nil) {
        
        let frame = CGRect(x: position.x - size.width / 2,
                           y: position.y - size.height / 2,
                           width: size.width,
                           height: size.height)
        let imageView = UIImageView(frame: frame)
        imageView.image = image
        view.addSubview(imageView)
        
        imageView.animateReveal(duration: duration, completion: { finished in
            imageView.removeFromSuperview()
            completion?(finished)
        })
    }
}

private extension UIView {
    
    func animateMove(to target: CGPoint,
                     duration: TimeInterval,
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
    
    func animateReveal(duration: TimeInterval,
                       completion: ((Bool) -> Void)?) {
        
        let scale: CGFloat = 1.4
        UIView.animateKeyframes(withDuration: duration,
                                delay: 0,
                                options: .calculationModeCubic,
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.1) {
                                        self.transform = CGAffineTransform(scaleX: scale, y: scale)
                                    }
                                },
                                completion: completion)
    }
}
