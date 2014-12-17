//
//  XPCardsAnimationController.swift
//  iOS-Cook-UI
//
//  Created by XP on 12/17/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

import UIKit

@objc(XPCardsAnimationController)
class XPCardsAnimationController: XPReversibleAnimationController {
    override func animateTransition(transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, toVC: UIViewController, fromView: UIView, toView: UIView) {
        if(self.reverse){
            self.executeReverseAnimation(transitionContext, fromVC: fromVC, toVC: toVC, fromView: fromView, toView: toView);
        }else{
            self.executeForwardsAnimation(transitionContext, fromVC: fromVC, toVC: toVC, fromView: fromView, toView: toView);
        }
    }
    
    func executeForwardsAnimation(transitionContext:UIViewControllerContextTransitioning, fromVC:UIViewController, toVC:UIViewController, fromView:UIView, toView:UIView){
        var containerView = transitionContext.containerView();
        var frame = transitionContext.initialFrameForViewController(fromVC);
        var offScreenFrame = frame;
        offScreenFrame.origin.y = offScreenFrame.size.height;
        toView.frame = offScreenFrame;
        
        containerView.insertSubview(toView, aboveSubview: fromView);
        var t1 = self.firstTransform();
        var t2 = self.secondTransformWithView(fromView);
        
        UIView.animateKeyframesWithDuration(self.transitionDuration(transitionContext), delay: 0.0, options: UIViewKeyframeAnimationOptions.CalculationModeCubic, animations: {()->() in
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.4, animations: {()->() in
                fromView.layer.transform = t1;
                fromView.alpha = 0.6;
            });
            UIView.addKeyframeWithRelativeStartTime(0.2, relativeDuration: 0.4, animations: {()->() in
                fromView.layer.transform = t2;
            });
            UIView.addKeyframeWithRelativeStartTime(0.6, relativeDuration: 0.2, animations: {()->() in
                toView.frame = CGRectOffset(toView.frame, 0.0, -30.0);
            });
            UIView.addKeyframeWithRelativeStartTime(0.8, relativeDuration: 0.2, animations: {()->() in
                toView.frame = frame;
            });
            }, completion: {(finished)->() in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled());
        });
    }
    
    func executeReverseAnimation(transitionContext:UIViewControllerContextTransitioning, fromVC:UIViewController, toVC:UIViewController, fromView:UIView, toView:UIView){
        var containerView = transitionContext.containerView();
        var frame = transitionContext.initialFrameForViewController(fromVC);
        toView.frame = frame;
        var scale = CATransform3DIdentity;
        toView.layer.transform = CATransform3DScale(scale, 0.6, 0.6, 1);
        toView.alpha = 0.6;
        containerView.insertSubview(toView, belowSubview: fromView);
        
        var frameOffScreen = frame;
        frameOffScreen.origin.y = frame.size.height;
        var t1 = self.firstTransform();
        
        UIView.animateKeyframesWithDuration(self.transitionDuration(transitionContext), delay: 0.0, options: UIViewKeyframeAnimationOptions.CalculationModeCubic, animations: {()->() in
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.5, animations: {()->() in
                fromView.frame = frameOffScreen;
            });
            UIView.addKeyframeWithRelativeStartTime(0.35, relativeDuration: 0.35, animations: {()->() in
                toView.layer.transform = t1;
                toView.alpha = 1.0;
            });
            UIView.addKeyframeWithRelativeStartTime(0.75, relativeDuration: 0.25, animations: {()->() in
                toView.layer.transform = CATransform3DIdentity;
            });
            }, completion: {(finished)->() in
                if(transitionContext.transitionWasCancelled()){
                    toView.layer.transform = CATransform3DIdentity;
                    toView.alpha = 1.0;
                }
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled());
        })
    }

    func firstTransform()->CATransform3D{
        var t1 = CATransform3DIdentity;
        t1.m34 = 1.0/(-900);
        t1 = CATransform3DScale(t1, 0.95, 0.95, 1);
        t1 = CATransform3DRotate(t1, 15.0*CGFloat(M_PI)/180.0, 1, 0, 0);
        return t1;
    }
    
    func secondTransformWithView(view:UIView)->CATransform3D{
        var t2 = CATransform3DIdentity;
        t2.m34 = self.firstTransform().m34;
        t2 = CATransform3DTranslate(t2, 0, view.frame.size.height*(-0.08), 0);
        t2 = CATransform3DScale(t2, 0.8, 0.8, 1);
        return t2;
    }
}
