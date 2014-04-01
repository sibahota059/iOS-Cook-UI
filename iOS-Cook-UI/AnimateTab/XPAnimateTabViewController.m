//
//  XPAnimateTabViewController.m
//  iOS-Cook-UI
//
//  Created by XP on 4/1/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import "XPAnimateTabViewController.h"


#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
#define IOS7_STATUS_BAR_HEIGHT (IS_IOS7 ? 20.0f : 0.0f)

@interface XPAnimateTabViewController ()

@end

@implementation XPAnimateTabViewController

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
    [self initTabScrollView];
    [self initContentScrollView];
    
    self.tabScrollView.tabNameArray = @[@"网易新闻", @"新浪微博新闻", @"搜狐", @"头条新闻", @"本地动态", @"精美图片集"];
    self.contentScrollView.contentNameArray = @[@"网易新闻", @"新浪微博新闻", @"搜狐", @"头条新闻", @"本地动态", @"精美图片集"];
    
    [self.tabScrollView initTabView];
    [self.contentScrollView initContentView];
}

- (void)initTabScrollView{
    self.tabScrollView = [[XPTabScrollView alloc] initWithFrame:CGRectMake(0, IOS7_STATUS_BAR_HEIGHT, 320, 44)];
    self.tabScrollView.mainViewController = self;
    [self.view addSubview:self.tabScrollView];
}

- (void)initContentScrollView{
    self.contentScrollView = [[XPContentScrollView alloc] initWithFrame:CGRectMake(0, 44 + IOS7_STATUS_BAR_HEIGHT, 320, self.view.frame.size.height - 44 - IOS7_STATUS_BAR_HEIGHT)];
    self.contentScrollView.mainViewController = self;
    [self.view addSubview:self.contentScrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
