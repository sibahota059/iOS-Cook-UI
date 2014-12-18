//
//  XPFoldAnimationController.swift
//  iOS-Cook-UI
//
//  Created by XP on 12/18/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

import UIKit

@objc(XPFoldAnimationController)
class XPFoldAnimationController: XPReversibleAnimationController {
    let folds:Int = 2;
    
    override func animateTransition(transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, toVC: UIViewController, fromView: UIView, toView: UIView) {
        var containerView = transitionContext.containerView();
        toView.frame = CGRectOffset(toView.frame, toView.frame.size.width, 0);
        containerView.addSubview(toView);
        
        var transform = CATransform3DIdentity;
        transform.m34 = -0.005;
        containerView.layer.sublayerTransform = transform;
        
        var size = toView.frame.size;
        var foldWidth = size.width*0.5/CGFloat(self.folds);
        
        var fromViewFolds = NSMutableArray();
        var toViewFolds = NSMutableArray();
        
        for(var i=0; i<self.folds;i++){
            var offset = CGFloat(i)*foldWidth*2;
            
            var leftFromViewFold = self.createSnapshotFromView(fromView, afterUpdates: false, offset: offset, left: true);
            leftFromViewFold.layer.position = CGPointMake(offset, size.height*0.5);
            fromViewFolds.addObject(leftFromViewFold);
            (leftFromViewFold.subviews[1] as UIView).alpha = 0.0;
            
            var rightFromViewFold = self.createSnapshotFromView(fromView, afterUpdates: false, offset: offset + foldWidth, left: false);
            rightFromViewFold.layer.position = CGPointMake(offset + foldWidth * 2, size.height * 0.5);
            fromViewFolds.addObject(rightFromViewFold);
            (rightFromViewFold.subviews[1] as UIView).alpha = 0.0;
            
            var leftToViewFold = self.createSnapshotFromView(toView, afterUpdates: true, offset: offset, left: true);
            leftToViewFold.layer.position = CGPointMake(self.reverse ? size.width : 0.0, size.height * 0.5);
            leftToViewFold.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI_2), 0.0, 1.0, 0.0);
            toViewFolds.addObject(leftToViewFold);
            
            var rightToViewFold = self.createSnapshotFromView(toView, afterUpdates: true, offset: offset + foldWidth, left: false);
            rightToViewFold.layer.position = CGPointMake(self.reverse ? size.width : 0.0, size.height * 0.5);
            rightToViewFold.layer.transform = CATransform3DMakeRotation(CGFloat(-M_PI_2), 0.0, 1.0, 0.0);
            toViewFolds.addObject(rightToViewFold);
        }
        
        fromView.frame = CGRectOffset(fromView.frame, fromView.frame.size.width, 0);
        
        var duration = self.transitionDuration(transitionContext);
        
        UIView.animateWithDuration(duration, animations: {()->() in
            for(var i = 0; i < self.folds; i++){
                var offset = CGFloat(i) * foldWidth * 2;
                
                var leftFromView: UIView = fromViewFolds[i*2] as UIView;
                leftFromView.layer.position = CGPointMake(self.reverse ? 0.0 : size.width, size.height * 0.5);
                leftFromView.layer.transform = CATransform3DRotate(transform, CGFloat(M_PI_2), 0.0, 1.0, 0.0);
                (leftFromView.subviews[1] as UIView).alpha = 1.0;
                
                var rightFromView: UIView = fromViewFolds[i*2+1] as UIView;
                rightFromView.layer.position = CGPointMake(self.reverse ? 0.0 : size.width, size.height * 0.5);
                rightFromView.layer.transform = CATransform3DRotate(transform, CGFloat(-M_PI_2), 0.0, 1.0, 0.0);
                (rightFromView.subviews[1] as UIView).alpha = 1.0;
                
                var leftToView: UIView = toViewFolds[i*2] as UIView;
                leftToView.layer.position = CGPointMake(offset, size.height * 0.5);
                leftToView.layer.transform = CATransform3DIdentity;
                (leftToView.subviews[1] as UIView).alpha = 0.0;
                
                var rightToView : UIView = toViewFolds[i*2 + 1] as UIView;
                rightToView.layer.position = CGPointMake(offset + foldWidth * 2, size.height * 0.5);
                rightToView.layer.transform = CATransform3DIdentity;
                (rightToView.subviews[1] as UIView).alpha = 0.0;
            }
            }, completion: {(finished)->() in
                for view in toViewFolds{
                    if let realView = view as? UIView{
                        realView.removeFromSuperview();
                    }
                }
                for view in fromViewFolds{
                    if let realView = view as? UIView{
                        realView.removeFromSuperview();
                    }
                }
                
                toView.frame = containerView.bounds;
                fromView.frame = containerView.bounds;
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled());
        })
    }
    
    func createSnapshotFromView(view:UIView, afterUpdates:Bool,offset:CGFloat,left:Bool)->UIView{
        var size = view.frame.size;
        var containerView = view.superview;
        var foldWidth = size.width * 0.5 / CGFloat(self.folds);
        
        var snapshotView:UIView;
        if(!afterUpdates){
            var snapshotRegion = CGRectMake(offset, 0.0, foldWidth, size.height);
            snapshotView = view.resizableSnapshotViewFromRect(snapshotRegion, afterScreenUpdates: afterUpdates, withCapInsets: UIEdgeInsetsZero);
        }else{
            snapshotView = UIView(frame: CGRectMake(0,0,foldWidth,size.height));
            snapshotView.backgroundColor = view.backgroundColor;
            var snapshotRegion = CGRectMake(offset, 0.0, foldWidth, size.height);
            var snapshotView2 = view.resizableSnapshotViewFromRect(snapshotRegion, afterScreenUpdates: afterUpdates, withCapInsets: UIEdgeInsetsZero);
            snapshotView.addSubview(snapshotView2);
        }
        
        var snapshotWithShadowView = self.addShadowToView(snapshotView, reverse: left);
        containerView?.addSubview(snapshotWithShadowView);
        snapshotWithShadowView.layer.anchorPoint = CGPointMake(left ? 0.0 : 1.0, 0.5);
        return snapshotWithShadowView;
    }
    
    func addShadowToView(view:UIView, reverse:Bool)->UIView{
        var viewWithShadow = UIView(frame: view.frame);
        var shadowView = UIView(frame: viewWithShadow.bounds);
        var gradient = CAGradientLayer();
        gradient.frame = shadowView.bounds;
        gradient.colors = [UIColor(white: 0.0, alpha: 0.0).CGColor,UIColor(white: 0.0, alpha: 1.0).CGColor];
        gradient.startPoint = CGPointMake(reverse ? 0.0 : 1.0, reverse ? 0.2 : 0.0);
        gradient.endPoint = CGPointMake(reverse ? 1.0 : 0.0, reverse ? 0.0 : 1.0);
        shadowView.layer.insertSublayer(gradient, atIndex: 1);
    
        view.frame = view.bounds;
        viewWithShadow.addSubview(view);
        viewWithShadow.addSubview(shadowView);
        return viewWithShadow;
    }
}
