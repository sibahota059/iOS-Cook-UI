//
//  XPRefreshTableViewController.swift
//  iOS-Cook-UI
//
//  Created by XP on 10/29/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

import UIKit

class XPRefreshTableViewController: UITableViewController {
    var header:XPRefreshHeaderView!;
    var footer:XPRefreshFooterView!;
    let reuseIdentifier:String = "reuseIdentifier";
    var rowCount:Int!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.configTableView();
    }
    
    override func viewDidAppear(animated:Bool){
        super.viewDidAppear(animated);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configTableView(){
        self.rowCount = 10;
        self.tableView.registerClass(UITableViewCell.self,forCellReuseIdentifier:self.reuseIdentifier);
        self.addRefreshHeaderViewWithAnimationView(XPRefreshCommonAnimationView(), beginRefresh: { () -> () in
            let delay = 2.0 * Double(NSEC_PER_SEC)
            var dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay));
            weak var weakSelf = self
            dispatch_after(dispatchTime, dispatch_get_main_queue(), {()->() in
                if let strongSelf = weakSelf {
                    strongSelf.rowCount = 20;
                    strongSelf.tableView.reloadData();
                    strongSelf.header.endRefreshingWithResult(XPRefreshResult.Success);
                }
            })
        });
        self.addRefreshFooterViewWithAnimationView(XPRefreshCommonAnimationView(), beginRefresh: { () -> () in
            let delay = 2.0 * Double(NSEC_PER_SEC)
            var dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay));
            weak var weakSelf = self
            dispatch_after(dispatchTime, dispatch_get_main_queue(), {()->() in
                if let strongSelf = weakSelf {
                    strongSelf.rowCount = strongSelf.rowCount + 10;
                    strongSelf.tableView.reloadData();
                    strongSelf.footer.endRefreshingWithResult(XPRefreshResult.Success);
                }
            })
        });
    }
    
    
    //MARK: config tableview
    func addRefreshHeaderViewWithAnimationView(animationView:XPRefreshAnimationBaseView, beginRefresh:()->()){
            var headerView:XPRefreshHeaderView = XPRefreshHeaderView();
            headerView.beginRefreshingClosure = beginRefresh;
            self.tableView.addSubview(headerView);
            self.header = headerView;
            headerView.animationView = animationView;
            headerView.addSubview(animationView);
    }
    
    func addRefreshFooterViewWithAnimationView(animationView:XPRefreshAnimationBaseView, beginRefresh:()->()){
            var footerView:XPRefreshFooterView = XPRefreshFooterView();
            footerView.beginRefreshingClosure = beginRefresh;
            self.tableView.addSubview(footerView);
            self.footer = footerView;
            footerView.animationView = animationView;
            footerView.addSubview(animationView);
    }

    
    //MARK: table delegate
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.rowCount;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var tableCell:UITableViewCell;
        if let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as? UITableViewCell{
            tableCell = cell;
        }else{
            tableCell = UITableViewCell(style: UITableViewCellStyle.Default,reuseIdentifier: self.reuseIdentifier);
        }
        // Configure the cell...
        tableCell.textLabel?.text = "aa";
        return tableCell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
