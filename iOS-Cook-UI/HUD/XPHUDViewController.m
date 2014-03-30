//
//  XPHUDViewController.m
//  iOS-Cook-UI
//
//  Created by XP on 3/28/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import "XPHUDViewController.h"
#import "XPHUD.h"
#import "AFNetworking.h"

static NSString *CellIdentifier = @"Cell";

@interface XPHUDViewController ()

@property (nonatomic, strong) NSArray *hudArray;
@property (nonatomic, strong) XPHUD *hud;

@end

@implementation XPHUDViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    self.hudArray = @[@"Show active only",@"Show caption only",@"show active with a caption"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.hudArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.textLabel.text = [self.hudArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            self.hud = [[XPHUD alloc] initWithTitle:nil type:XPHUDTypeActivityIndicatorOnly image:nil];
            [self.hud showInView:self.view];
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
            [manager GET:@"http://m.weather.com.cn/data/101010100.html" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                [self.hud remove];
                self.hud = [[XPHUD alloc] initWithTitle:nil type:XPHUDTypeCustomImageOnly image:[UIImage imageNamed:@"Succeed"]];
                [self.hud showInView:self.view];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [self.hud remove];
                self.hud = [[XPHUD alloc] initWithTitle:nil type:XPHUDTypeCustomImageOnly image:[UIImage imageNamed:@"Fail"]];
                [self.hud showInView:self.view];
            }];
        }
            break;
            
        default:
            break;
    }
}

- (void)myTask {
	// Do something usefull in here instead of sleeping ...
	sleep(3);
}


@end
