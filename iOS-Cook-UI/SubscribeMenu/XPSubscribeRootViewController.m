//
//  XPsSubscribeRootViewController.m
//  iOS-Cook-UI
//
//  Created by XP on 5/15/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import "XPSubscribeRootViewController.h"
#import "XPSubscribeButton.h"
#import "XPSubscribeMenuViewController.h"
#import "XPMenuView.h"
#import "XPMenu.h"

@interface XPSubscribeRootViewController ()

@end

@implementation XPSubscribeRootViewController

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
    XPSubscribeButton *subscribeBtn = [XPSubscribeButton subscribeButtonWithViewController:self
                                                                                titleArray:[NSArray arrayWithObjects:@"头条",@"娱乐",@"健康",@"星座",@"社会",@"佛教",@"时事",@"时尚",@"军事",@"旅游",@"房产",@"汽车",@"港澳",@"教育",@"历史",@"文化",@"财经",@"读书",@"台湾",@"体育",@"科技",@"评论", nil]
                                                                            urlStringArray:[NSArray arrayWithObjects:@"http://api.3g.ifeng.com/iosNews?id=aid=SYLB10&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=YL53&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=JK36&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=XZ09&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=SH133&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=FJ31&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=XW23&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=SS78&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=JS83&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=LY67&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=FC81&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=QC45&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=GA18&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=JY90&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=LS153&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=WH25&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=CJ33&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=DS57&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=TW73&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=TY43,FOCUSTY43&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=KJ123&imgwidth=100&type=list&pagesize=20",@"http://api.3g.ifeng.com/iosNews?id=aid=PL40&imgwidth=100&type=list&pagesize=20",nil]];
    subscribeBtn.frame = CGRectMake(self.view.frame.size.width - 63, 10, 63, 45);
    [self.view addSubview:subscribeBtn];
    [subscribeBtn addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)showMenu:(id)sender{
    XPSubscribeButton *button = (XPSubscribeButton *)sender;
    XPSubscribeMenuViewController *menuVC = [[XPSubscribeMenuViewController alloc] init];
    menuVC.titleArray = button.titleArray;
    menuVC.urlStringArray = button.urlStringArray;
    UIView *menuView = menuVC.view;
    [menuView setFrame:CGRectMake(0, - button.vc.view.bounds.size.height, button.vc.view.bounds.size.width, button.vc.view.bounds.size.height)];
    [menuView setBackgroundColor:[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0]];
    [menuVC.backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:menuVC.view];
    [self addChildViewController:menuVC];
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         [menuVC.view setFrame:CGRectMake(0, 0, button.vc.view.bounds.size.width, button.vc.view.bounds.size.height)];
                     }
                     completion:nil];
}

- (void)backAction{
    XPSubscribeMenuViewController *vc = (XPSubscribeMenuViewController *)[self.childViewControllers objectAtIndex:0];
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         [vc.view setFrame:CGRectMake(0, -self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height)];
                     }
                     completion:^(BOOL finished){
                         NSString *string = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                         NSString *filePath = [string stringByAppendingString:@"/modelArray0.swh"];
                         NSString *filePath1 = [string stringByAppendingString:@"/modelArray1.swh"];
                         NSMutableArray *modelArray = [NSMutableArray array];
                         
                         for (XPMenuView *menuView in vc.menuViewArray1) {
                             [modelArray addObject:menuView.menu];
                         }
                         NSData *data = [NSKeyedArchiver archivedDataWithRootObject:modelArray];
                         [data writeToFile:filePath atomically:YES];
                         [modelArray removeAllObjects];
                         for (XPMenuView *menuView in vc.menuViewArray2) {
                             [modelArray addObject:menuView.menu];
                         }
                         data = [NSKeyedArchiver archivedDataWithRootObject:modelArray];
                         [data writeToFile:filePath1 atomically:YES];
                         [[[self.childViewControllers objectAtIndex:0] view] removeFromSuperview];
                         [vc removeFromParentViewController];
                     }];
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
