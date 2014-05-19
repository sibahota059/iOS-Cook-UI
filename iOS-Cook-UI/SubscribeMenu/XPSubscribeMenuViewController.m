//
//  XPSubscribeMenuViewController.m
//  iOS-Cook-UI
//
//  Created by XP on 5/15/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import "XPSubscribeMenuViewController.h"
#import "XPMenu.h"
#import "XPMenuView.h"

@interface XPSubscribeMenuViewController ()


@property (nonatomic, strong) UILabel *titleLabel1;
@property (nonatomic, strong) UILabel *titlelabel2;

@end

@implementation XPSubscribeMenuViewController

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
    NSString *string = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [string stringByAppendingString:@"/modelArray0.swh"];
    NSString *filePath1 = [string stringByAppendingString:@"/modelArray1.swh"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSArray *channelListArray = self.titleArray;
        NSArray *channelUrlStringListArray = self.urlStringArray;
        NSMutableArray *mutableArray = [NSMutableArray array];
        for (int i = 0; i < [channelListArray count]; i++) {
            NSString *title = [channelListArray objectAtIndex:i];
            NSString *urlString = [channelUrlStringListArray objectAtIndex:i];
            XPMenu *menu = [[XPMenu alloc] initWIthTitle:title urlString:urlString];
            [mutableArray addObject:menu];
            if (i == 9) {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:mutableArray];
                [data writeToFile:filePath atomically:YES];
                [mutableArray removeAllObjects];
            }else if(i == channelListArray.count - 1){
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:mutableArray];
                [data writeToFile:filePath1 atomically:YES];
            }
        }
    }
    
    NSArray *menuArray1 = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSArray *menuArray2 = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath1];
    self.menuViewArray1 = [NSMutableArray array];
    self.menuViewArray2 = [NSMutableArray array];
    
    self.titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(110, 25, 100, 40)];
    self.titleLabel1.text = @"我的订阅";
    [self.titleLabel1 setTextAlignment:NSTextAlignmentCenter];
    [self.titleLabel1 setTextColor:[UIColor colorWithRed:187/255.0 green:1/255.9 blue:1/255.0 alpha:1.0]];
    [self.view addSubview:self.titleLabel1];
    
    self.titlelabel2 = [[UILabel alloc] initWithFrame:CGRectMake(110, 60 + 40 * ((menuArray1.count - 1)/5 + 1) + 22, 100, 20)];
    self.titlelabel2.text = @"更多频道";
    [self.titlelabel2 setFont:[UIFont systemFontOfSize:10]];
    [self.titlelabel2 setTextAlignment:NSTextAlignmentCenter];
    [self.titlelabel2 setTextColor:[UIColor grayColor]];
    [self.view addSubview:self.titlelabel2];
    
    for (int i = 0; i < menuArray1.count; i++) {
        XPMenuView *menuView = [[XPMenuView alloc] initWithFrame:CGRectMake(25 + 54 * (i%5), 60 + 40 * (i/5), 54, 40)];
        [menuView setBackgroundColor:[UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1.0]];
        [self.menuViewArray1 addObject:menuView];
        menuView.array = self.menuViewArray1;
        if (i == 0) {
            [menuView.label setTextColor:[UIColor colorWithRed:187/255.0 green:1/255.0 blue:1/255.0 alpha:1.0]];
        }else{
            [menuView.label setTextColor:[UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:1.0]];
        }
        menuView.label.text = [[menuArray1 objectAtIndex:i] title];
        [menuView.label setTextAlignment:NSTextAlignmentCenter];
        [menuView setMoreChannelsLabel:self.titlelabel2];
        menuView.viewArray1 = self.menuViewArray1;
        menuView.viewArray2 = self.menuViewArray2;
        menuView.menu = [menuArray1 objectAtIndex:i];
        [self.view addSubview:menuView];
    }
    
    for (int i = 0; i < menuArray2.count; i ++) {
        XPMenuView  *menuView = [[XPMenuView alloc] initWithFrame:CGRectMake(25 + 54 *(i%5), 100 + 40 * ((menuArray1.count - 1)/5 + 1) + 40 * (i/5), 54, 40)];
        [menuView setBackgroundColor:[UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1.0]];
        [self.menuViewArray2 addObject:menuView];
        menuView.array = self.menuViewArray2;
        menuView.label.text = [[menuArray2 objectAtIndex:i] title];
        [menuView.label setTextColor:[UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:1.0]];
        [menuView.label setTextAlignment:NSTextAlignmentCenter];
        [menuView setMoreChannelsLabel:self.titlelabel2];
        menuView.viewArray1 = self.menuViewArray1;
        menuView.viewArray2 = self.menuViewArray2;
        [menuView setMenu:[menuArray2 objectAtIndex:i]];
        [self.view addSubview:menuView];
    }
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton setFrame:CGRectMake(self.view.bounds.size.width - 56, self.view.bounds.size.height - 108, 56, 44)];
    [self.backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.backButton setImage:[UIImage imageNamed:@"back_hl"] forState:UIControlStateHighlighted];
    [self.view addSubview:self.backButton];
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
