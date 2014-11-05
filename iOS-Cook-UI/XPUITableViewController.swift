//
//  XPUITableViewController.swift
//  iOS-Cook-UI
//
//  Created by XP on 10/29/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

import UIKit

class XPUITableViewController: UITableViewController {
    
    var uiArray:[String]!;
    let reuseIdentifier = "reuseIdentifier";

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier);

        var array: NSArray?
        if let path = NSBundle.mainBundle().pathForResource("UIList", ofType: "plist") {
            array = NSArray(contentsOfFile: path)
            self.uiArray = array as? [String];
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if let array = self.uiArray{
            return array.count;
        }else{
            return 0;
        }
    }

    // MARK: table delegate
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var tableCell:UITableViewCell;
        if let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as? UITableViewCell{
            tableCell = cell;
        }else{
            tableCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier);
        }
        tableCell.textLabel.text = self.uiArray?[indexPath.row];

        // Configure the cell...

        return tableCell;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        var cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!;
        if(cell.textLabel.text == "Table Refresh"){
            var refreshTable:XPRefreshTableViewController = XPRefreshTableViewController();
            self.navigationController?.pushViewController(refreshTable, animated: true);
        }
    }

}
