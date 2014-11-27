//
//  XPTransitionSettingViewController.swift
//  iOS-Cook-UI
//
//  Created by XP on 11/24/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

import UIKit

class XPTransitionSettingViewController: UITableViewController {
    
    let animationControllers = ["None", "Portal", "Cards", "Fold", "Explode", "Flip", "Turn", "Crossfade", "NatGeo", "Cube","Pan"];
    let interationControllers = ["None", "HorizontalSwipe" ,"VerticalSwipe", "Pinch"];

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
            return animationControllers.count;
        }else{
            return interationControllers.count;
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
        var transitionName = cell.textLabel.text;
        var currentTransition:AnyObject;
        if(indexPath.section < 2){
            currentTransition = indexPath.section == 0 ? 
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell;
        if (cell == nil){
            cell = UITableViewCell();
        }
        if(indexPath.section < 2){
            cell?.textLabel.text = animationControllers[indexPath.row];
        }else{
            cell?.textLabel.text = interationControllers[indexPath.row];
        }
        return cell!;
    }
}
