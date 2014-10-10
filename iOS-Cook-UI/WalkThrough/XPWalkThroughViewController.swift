//
//  XPWalkThroughViewController.swift
//  iOS-Cook-UI
//
//  Created by XP on 10/9/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

import UIKit

class XPWalkThroughViewController: UIViewController, XPWalkThroughContainerViewControllerDelegate {
    @IBAction func showBtnClicked(sender: AnyObject) {
        showWalkThrough();
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        let userDefualts = NSUserDefaults.standardUserDefaults();
        if(!userDefualts.boolForKey("walkthroughPresented")){
            showWalkThrough();
            userDefualts.setBool(true, forKey: "walkthroughPresented");
            userDefualts.synchronize();
        }
    }
    
    func showWalkThrough(){
        let stb = UIStoryboard(name: "WalkThrough", bundle: nil);
        let walkThrough = stb.instantiateViewControllerWithIdentifier("walkContainer") as XPWalkThroughContainerViewController;
        let page0 = stb.instantiateViewControllerWithIdentifier("walk0") as UIViewController;
        let page1 = stb.instantiateViewControllerWithIdentifier("walk1") as UIViewController;
        let page2 = stb.instantiateViewControllerWithIdentifier("walk2") as UIViewController;
        let page3 = stb.instantiateViewControllerWithIdentifier("walk3") as UIViewController;
        
        walkThrough.delegate = self;
        walkThrough.addViewController(page0);
        walkThrough.addViewController(page1);
        walkThrough.addViewController(page2);
        walkThrough.addViewController(page3);
        
        self.presentViewController(walkThrough, animated: true, completion: nil);
    }
    
    // MARK: - XPWalkThroughContainerViewControllerDelegate -
    func walkthroughCloseBtnClicked(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func walkthroughPageDidChange(pageNumber:Int){}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
