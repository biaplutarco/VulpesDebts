//
//  CircularTransition.swift
//  Dox
//
//  Created by Bia Plutarco on 26/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

enum TransitionMode: Int {
    case present, dismiss
}

class CircularTransition: NSObject {
    //  View Collored
    var coloredView = UIView()
    
    var color = UIColor()
    
    var heightColoredView = CGFloat()
    
    var widthColoredView = CGFloat()
    
    // CGPoints
    var startingPoint = CGPoint.zero
    
    var middlePoint = CGPoint()
    
    var endPoint = CGPoint()
    
    //  Presented View
    var presentedViewCenter = CGPoint.zero
    
    var presentedViewSize = CGSize()
    
    //  Mode
    var transitionMode: TransitionMode = .present
}

extension CircularTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        if transitionMode == .present {
            if let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to){
                //  Setting ColoredView
                coloredView = UIView()
                coloredView.frame.size = CGSize(width: widthColoredView, height: heightColoredView)
                coloredView.layer.cornerRadius = heightColoredView/2
                coloredView.center = startingPoint
                coloredView.backgroundColor = color
                coloredView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                containerView.addSubview(coloredView)
                //  Setting PresentedView
                presentedView.alpha = 0
                containerView.addSubview(presentedView)
                
                //  Starting Animation
                UIView.animateKeyframes(withDuration: 1.6, delay: 0, options: .calculationModeCubic, animations: {
                    //  Open the circle and centered it
                    UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2, animations: {
                        self.coloredView.transform = CGAffineTransform.identity
                        self.coloredView.center = self.middlePoint
                        containerView.bringSubviewToFront(self.coloredView)
                        presentedView.frame.size = self.presentedViewSize
                        presentedView.alpha = 0
                    })
                    //  Move circle
                    UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.6, animations: {
                        self.coloredView.center = self.endPoint
                        self.coloredView.transform = CGAffineTransform(scaleX: 2, y: 2)
                    })
                    //  Resize circle
                    UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 1.2, animations: {
                        self.coloredView.transform = CGAffineTransform(a: 0, b: 0, c: 0, d: 0, tx: 0.5, ty: 0.5)
                    })
                    // Show the NextVC
                    UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.1, animations: {
                        presentedView.center = self.presentedViewCenter
                        presentedView.alpha = 1
                    })
                }, completion: { (success: Bool) in
                    transitionContext.completeTransition(success)
                })
            }
        } else {
            if let returningView = transitionContext.view(forKey: UITransitionContextViewKey.from) {
                //  Setting ColoredView
                coloredView = UIView()
                coloredView.frame.size = CGSize(width: widthColoredView, height: heightColoredView)
                coloredView.layer.cornerRadius = heightColoredView/2
                coloredView.center = startingPoint
                coloredView.backgroundColor = color
                coloredView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                containerView.addSubview(coloredView)
                
                //  Starting Animation
                UIView.animateKeyframes(withDuration: 1.6, delay: 0, options: .calculationModeCubic, animations: {
                    //  Open the circle and centered it
                    UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.6, animations: {
                        self.coloredView.transform = CGAffineTransform.identity
                        self.coloredView.center = self.middlePoint
                        containerView.bringSubviewToFront(self.coloredView)
                        self.coloredView.transform = CGAffineTransform(scaleX: 2, y: 2)
                    })
                    //  Move circle
                    UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.6, animations: {
                        self.coloredView.center = self.endPoint
                        self.coloredView.transform = CGAffineTransform(scaleX: 2, y: 2)
                    })
                    // Resize circle
                    UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 1.2, animations: {
                        self.coloredView.transform = CGAffineTransform(a: 0, b: 0, c: 0, d: 0, tx: 0.5, ty: 0.5)
                    })
                    // Show the NextVC
                    UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.3, animations: {
                        returningView.alpha = 0
                    })
                }) { (success: Bool) in
                    returningView.removeFromSuperview()
                    self.coloredView.removeFromSuperview()
                    transitionContext.completeTransition(success)
                }
            }
        }
    }
}
