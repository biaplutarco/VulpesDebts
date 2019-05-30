//
//  HomeCustomTransition.swift
//  ZombieChallenge
//
//  Created by Bia Plutarco on 29/11/18.
//  Copyright © 2018 Elias Paulino. All rights reserved.
//

import UIKit

enum TransitionMode: Int {
    case present, dismiss
}

class CustomTransition: NSObject {
    var circleView: UIView = {
        let circle = UIView()
        circle.backgroundColor = UIColor.AppColors.orange
        return circle
    }()
    
    var startingPoint: CGPoint
    var viewCenter: CGPoint
    var duration: TimeInterval
    var transitionMode: TransitionMode = .present
    
    init(size: CGFloat, startingPoint: CGPoint, viewCenter: CGPoint, duration: TimeInterval) {
        self.startingPoint = startingPoint
        self.viewCenter = viewCenter
        self.duration = duration
        super.init()
        configCircleView(size: size)
    }
    
    private func configCircleView(size: CGFloat) {
        circleView.frame = CGRect(origin: startingPoint, size: CGSize(width: size*2, height: size*2))
        circleView.layer.cornerRadius = size
//        Setting circleView to animation
        switch transitionMode {
        case .present:
            circleView.center = self.startingPoint
            circleView.transform = CGAffineTransform(scaleX: 0.004, y: 0.004)
        case .dismiss:
            circleView.alpha = 0.5
            circleView.transform = CGAffineTransform.identity
        }
    }
//    TransitionModeAnimation:
//    PresenteAimation
    private func presentAnimation(presentedView: UIView, transitionContext: UIViewControllerContextTransitioning) {
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModeLinear, animations: {
            let duration = self.duration
//            Open the circle and centered it
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: duration, animations: {
                self.circleView.transform = CGAffineTransform.identity
                presentedView.transform = CGAffineTransform.identity
                presentedView.center = self.viewCenter
            })
//            Show the NextVC
            UIView.addKeyframe(withRelativeStartTime: duration, relativeDuration: duration/2, animations: {
                presentedView.alpha = 0.5
            })
            UIView.addKeyframe(withRelativeStartTime: duration + duration/2, relativeDuration: duration/2, animations: {
                presentedView.alpha = 1
            })
        }, completion: { (success: Bool) in
            transitionContext.completeTransition(success)
        })
    }
//    DismissAnimation
    private func dismissAnimation(returningView: UIView, transitionContext: UIViewControllerContextTransitioning) {
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModeLinear, animations: {
//            Open the circle and centered it
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: self.duration*2, animations: {
                self.circleView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                self.circleView.center = self.startingPoint
                returningView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                returningView.center = self.startingPoint
            })
//            Show the NextVC
            UIView.addKeyframe(withRelativeStartTime: self.duration*2, relativeDuration: self.duration, animations: {
                returningView.alpha = 0
            })
            UIView.addKeyframe(withRelativeStartTime: self.duration*3, relativeDuration: self.duration, animations: {
                returningView.removeFromSuperview()
            })
        }, completion: {(success: Bool) in
            transitionContext.completeTransition(success)
        })
    }
}
//AnimatedTransitioning
extension CustomTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        containerView.addSubview(circleView)
        switch transitionMode {
        case .present:
            guard let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
//            Setting PresentedView
            presentedView.alpha = 0
            presentedView.center = startingPoint
            presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            containerView.addSubview(presentedView)
//            Animation
            presentAnimation(presentedView: presentedView, transitionContext: transitionContext)
        case .dismiss:
            guard let returningView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
//            Animation
            dismissAnimation(returningView: returningView, transitionContext: transitionContext)
        }
    }
}
