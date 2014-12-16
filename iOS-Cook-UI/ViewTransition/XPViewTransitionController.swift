//
//  XPViewTransitionController.swift
//  iOS-Cook-UI
//
//  Created by XP on 11/24/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

import UIKit

class XPViewTransitionController: UIViewController, UIViewControllerTransitioningDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "UIView Transition";
        self.initTransitionButton();
        self.initSettingButton();
    }
    
    func initSettingButton(){
        var settingBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action:Selector("showSettingViewController"));
        self.navigationItem.rightBarButtonItem = settingBarButton;
    }
    
    func showSettingViewController(){
        var navigation = UINavigationController(rootViewController: XPTransitionSettingViewController());
        navigation.transitioningDelegate = self;
        self.presentViewController(navigation, animated: true, completion: nil);
    }
    
    func initTransitionButton(){
        var button = UIButton();
        button.setTitle("Transition", forState: UIControlState.Normal);
        button.tintColor = UIColor.whiteColor();
        button.sizeToFit();
        self.view.addSubview(button);
        button.setTranslatesAutoresizingMaskIntoConstraints(false);
        var constraintCenterX = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0);
        var constraintCenterY = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0);
        self.view.addConstraints([constraintCenterX,constraintCenterY]);

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - UIViewControllerTransitioningDelegate
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let settingsInteractionController = XPTransitionPreference.shareInstance().settingsInteractionController{
            settingsInteractionController.wireToViewController(presented, forOperation: XPInteractionOperation.Dismiss)
        }
        
        XPTransitionPreference.shareInstance().settingsAnimationController?.reverse = false;
        return XPTransitionPreference.shareInstance().settingsAnimationController?;
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        XPTransitionPreference.shareInstance().settingsAnimationController?.reverse = true;
        return XPTransitionPreference.shareInstance().settingsAnimationController?;
    }

}
