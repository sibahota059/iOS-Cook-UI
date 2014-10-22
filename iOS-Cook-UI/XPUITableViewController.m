//
//  XPUITableViewController.m
//  iOS-Cook-UI
//
//  Created by XP on 3/18/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import "XPUITableViewController.h"

static NSString *CellIdentifier = @"Cell";

@interface XPUITableViewController ()

@property (nonatomic, strong) NSArray *uiArray;

@end

@implementation XPUITableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSURL *path = [[NSBundle mainBundle] URLForResource:@"UIList" withExtension:@"plist"];
    self.uiArray = [NSArray arrayWithContentsOfURL:path];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.uiArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [self.uiArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[self.uiArray objectAtIndex:indexPath.row] isEqualToString:@"Blur Slide Bar"]) {
        [self performSegueWithIdentifier:@"pushBlurSlideBarViewController" sender:self];
    }else if ([[self.uiArray objectAtIndex:indexPath.row] isEqualToString:@"Drawer View Controller"]){
        [self performSegueWithIdentifier:@"pushDrawerViewController" sender:self];
    }else if([[self.uiArray objectAtIndex:indexPath.row] isEqualToString:@"Animate Tab View Controller"]){
        [self performSegueWithIdentifier:@"pushAnimateTabViewController" sender:self];
    }else if ([[self.uiArray objectAtIndex:indexPath.row] isEqualToString:@"Photo Scan"]){
        [self performSegueWithIdentifier:@"pushPhotoBrowseViewController" sender:self];
    }else if([[self.uiArray objectAtIndex:indexPath.row] isEqualToString:@"Zone Refresh"]){
        [self performSegueWithIdentifier:@"pushZoneRefresh" sender:self];
    }else if([[self.uiArray objectAtIndex:indexPath.row] isEqualToString:@"Walk Through"]){
        [self performSegueWithIdentifier:@"pushWalkThroughViewController" sender:self];
    }else if([[self.uiArray objectAtIndex:indexPath.row] isEqualToString:@"Image Processing"]){
        [self performSegueWithIdentifier:@"pushImageProcessingViewController" sender:self];
    }
}

@end
