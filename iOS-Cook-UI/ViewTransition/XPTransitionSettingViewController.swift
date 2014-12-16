//
//  XPTransitionSettingViewController.swift
//  iOS-Cook-UI
//
//  Created by XP on 11/24/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

import UIKit

class XPTransitionSettingViewController: UITableViewController {
    
    let _animationControllers = ["None", "Portal", "Cards", "Fold", "Explode", "Flip", "Turn", "Crossfade", "NatGeo", "Cube","Pan"];
    let _interactionControllers = ["None", "HorizontalSwipe" ,"VerticalSwipe", "Pinch"];

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initDoneButton();

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func initDoneButton(){
        var doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: Selector("dismiss"));
        self.navigationItem.rightBarButtonItem = doneButton;
    }
    
    func classToTransitionName(obj:AnyObject?) -> String{
        if let object: AnyObject = obj{
            var animationClass = NSStringFromClass(object_getClass(object));
            var transitionName:NSMutableString = NSMutableString(string: animationClass);
            transitionName.replaceOccurrencesOfString("XP", withString: "", options: NSStringCompareOptions.CaseInsensitiveSearch, range: NSMakeRange(0, transitionName.length));
            transitionName.replaceOccurrencesOfString("AnimationController", withString: "", options: NSStringCompareOptions.CaseInsensitiveSearch, range: NSMakeRange(0, transitionName.length));
            transitionName.replaceOccurrencesOfString("InteractionController", withString: "", options: NSStringCompareOptions.CaseInsensitiveSearch, range: NSMakeRange(0, transitionName.length));
            return transitionName;
        }else{
            return "None";
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismiss(){
        self.dismissViewControllerAnimated(true, completion: nil);
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 4;
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if(section < 2){
            return _animationControllers.count;
        }else{
            return _interactionControllers.count;
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0){
            return "Navigation push / pop animation controller";
        }
        
        if (section == 1){
            return "Settings present / dismiss animation controller";
        }
        
        if (section == 2){
            return "Navigation push / pop interaction controller";
        }
        
        if (section == 3){
            return "Settings present / dismiss interaction controller";
        }
        
        return "";

    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        var transitionName = cell.textLabel?.text;
        var currentTransition:AnyObject?;
        if(indexPath.section < 2){
            currentTransition = (indexPath.section == 0 ? XPTransitionPreference.shareInstance().navigationControllerAnimationController : XPTransitionPreference.shareInstance().settingsAnimationController);
        }else{
            currentTransition = (indexPath.section == 2 ? XPTransitionPreference.shareInstance().navigationControllerInteractionCotroller : XPTransitionPreference.shareInstance().settingsInteractionController);
        }
        var transitionClassName = self.classToTransitionName(currentTransition);
        cell.accessoryType = transitionName == transitionClassName ? UITableViewCellAccessoryType.Checkmark : UITableViewCellAccessoryType.None;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell;
        if (cell == nil){
            cell = UITableViewCell();
        }
        if(indexPath.section < 2){
            cell?.textLabel?.text = _animationControllers[indexPath.row];
        }else{
            cell?.textLabel?.text = _interactionControllers[indexPath.row];
        }
        return cell!;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section < 2) {
            // an animation controller was selected
            var transitionName = _animationControllers[indexPath.row];
            var transitionObject:NSObject = NSNull();
            if(transitionName.lowercaseString != "none"){
                var className = "XP" + transitionName + "AnimationController";
                let transitionClass: AnyClass! = NSClassFromString(className);
                var transitionType:NSObject.Type! = transitionClass as NSObject.Type;
                transitionObject = transitionType() as NSObject;
            }
            
            
            if (indexPath.section == 0) {
                XPTransitionPreference.shareInstance().navigationControllerAnimationController = transitionObject as? XPReversibleAnimationController;
            }
            if (indexPath.section == 1) {
                XPTransitionPreference.shareInstance().settingsAnimationController = transitionObject as? XPReversibleAnimationController;
            }
        } else {
            // an interaction cntroller was selected
            var transitionName = _interactionControllers[indexPath.row];
            var transitionObject:NSObject = NSNull();
            if(transitionName.lowercaseString == "none"){
                var className = "XP" + transitionName + "@InteractionController";
                let transitionClass:AnyClass! = NSClassFromString(className);
                var transitionType:NSObject.Type = transitionClass as NSObject.Type;
                transitionObject = transitionType() as NSObject;
            }
            
            if (indexPath.section == 2) {
                XPTransitionPreference.shareInstance().navigationControllerInteractionCotroller = transitionObject as? XPBaseInteractionController;
            }
            if (indexPath.section == 3) {
                XPTransitionPreference.shareInstance().settingsInteractionController = transitionObject as? XPBaseInteractionController;
            }
        }
        self.tableView.reloadData();
    }
}
