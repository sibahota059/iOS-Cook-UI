//
//  XPReversibleAnimationController.swift
//  iOS-Cook-UI
//
//  Created by XP on 11/25/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

import UIKit

class XPReversibleAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    var reverse:Bool = false;
    
    //MARK: - UIViewControllerAnimatedTransitioning
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 1.0;
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        var fromVC:UIViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!;
        var toVC:UIViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!;
        var toView = toVC.view;
        var fromView = fromVC.view;
        
        self.animateTransition(transitionContext, fromVC: fromVC, toVC: toVC, fromView: fromView, toView: toView);
    }
    
    func animateTransition(transitionContext:UIViewControllerContextTransitioning, fromVC:UIViewController, toVC:UIViewController,fromView:UIView, toView:UIView){
        //this should be overriden
    }
}
