//
//  XPPortalAnimationController.swift
//  iOS-Cook-UI
//
//  Created by XP on 12/4/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

import UIKit

@objc(XPPortalAnimationController)
class XPPortalAnimationController: XPReversibleAnimationController {
    override func animateTransition(transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, toVC: UIViewController, fromView: UIView, toView: UIView) {
        if(self.reverse == true){
            self.executeReverseAnimation(transitionContext, fromVC: fromVC, toVC: toVC, fromView: fromView, toView: toView);
        }else{
            self.executeForwardsAnimation(transitionContext, fromVC: fromVC, toVC: toVC, fromView: fromView, toView: toView);
        }
    }
    
    func executeReverseAnimation(transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, toVC: UIViewController, fromView: UIView, toView: UIView){
        var containerView = transitionContext.containerView();
        containerView.addSubview(fromView);
        toView.frame = CGRectOffset(toView.frame, toView.frame.size.width, 0);
        containerView .addSubview(toView);
        
        var leftSnapshotRegion = CGRectMake(0, 0, toView.frame.size.width*0.5, toView.frame.size.height);
        var leftHandView = toView.resizableSnapshotViewFromRect(leftSnapshotRegion, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero);
        leftHandView.frame = leftSnapshotRegion;
        leftHandView.frame = CGRectOffset(leftHandView.frame, -leftHandView.frame.size.width, 0);
        containerView.addSubview(leftHandView);
        
        var rightSnapshotRegion = CGRectMake(toView.frame.size.width * 0.5, 0, toView.frame.size.width*0.5, toView.frame.size.height);
        var rightHandView = toView.resizableSnapshotViewFromRect(rightSnapshotRegion, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero);
        rightHandView.frame = rightSnapshotRegion;
        rightHandView.frame = CGRectOffset(rightHandView.frame, rightHandView.frame.size.width, 0);
        containerView.addSubview(rightHandView);
        
        var duration:NSTimeInterval = self.transitionDuration(transitionContext);
        UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {()->() in
            leftHandView.frame = CGRectOffset(leftHandView.frame, leftHandView.frame.size.width, 0);
            rightHandView.frame = CGRectOffset(rightHandView.frame, -rightHandView.frame.size.width, 0);
            var scale = CATransform3DIdentity;
            fromView.layer.transform = CATransform3DScale(scale, 0.8, 0.8, 1);
            }, completion: {(finished)-> () in
                if(transitionContext.transitionWasCancelled()){
                    self.removeOtherViews(fromView);
                }else{
                    self.removeOtherViews(toView);
                    toView.frame = containerView.bounds;
                }
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled());
        });
        
    }
    
    func executeForwardsAnimation(transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, toVC: UIViewController, fromView: UIView, toView: UIView){
        var containerView = transitionContext.containerView();
        
        var toViewSnapshot = toView.resizableSnapshotViewFromRect(toView.frame, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero);
        var scale:CATransform3D = CATransform3DIdentity;
        toViewSnapshot.layer.transform = CATransform3DScale(scale, 0.8, 0.8, 1);
        containerView.addSubview(toViewSnapshot);
        containerView.sendSubviewToBack(toViewSnapshot);
        
        var leftSnapshotRegion:CGRect = CGRectMake(0, 0, fromView.frame.size.width * 0.5, fromView.frame.size.height);
        var leftHandView = fromView.resizableSnapshotViewFromRect(leftSnapshotRegion, afterScreenUpdates: false, withCapInsets: UIEdgeInsetsZero);
        leftHandView.frame = leftSnapshotRegion;
        containerView.addSubview(leftHandView);
        var rightSnapshotRegion:CGRect = CGRectMake(fromView.frame.size.width * 0.5, 0, fromView.frame.size.width * 0.5, fromView.frame.size.height);
        var rightHandView = fromView.resizableSnapshotViewFromRect(rightSnapshotRegion, afterScreenUpdates: false, withCapInsets: UIEdgeInsetsZero);
        rightHandView.frame = rightSnapshotRegion;
        containerView.addSubview(rightHandView);
        
        fromView.removeFromSuperview();
        
        var duration:NSTimeInterval = self.transitionDuration(transitionContext);
        
        UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { ()->() in
            leftHandView.frame = CGRectOffset(leftHandView.frame, -leftHandView.frame.size.width, 0);
            rightHandView.frame = CGRectOffset(rightHandView.frame, rightHandView.frame.size.width, 0);
            
            toViewSnapshot.center = toView.center;
            toViewSnapshot.frame = toView.frame;
            }, completion: { (finished) -> () in
            if(transitionContext.transitionWasCancelled()){
                containerView.addSubview(fromView);
                self.removeOtherViews(fromView);
            }else{
                containerView.addSubview(toView);
                self.removeOtherViews(toView);
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled());
        });
    }
    
    func removeOtherViews(viewToKeep:UIView){
        var containerView:UIView = viewToKeep.superview!;
        for view in containerView.subviews{
            if(view as UIView != viewToKeep){
                view.removeFromSuperview();
            }
        }
    }
}
