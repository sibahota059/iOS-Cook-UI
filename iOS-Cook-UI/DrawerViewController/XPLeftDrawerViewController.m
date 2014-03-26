//
//  XPLeftDrawerViewController.m
//  iOS-Cook-UI
//
//  Created by XP on 3/25/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import "XPLeftDrawerViewController.h"
#import "XPDrawerModel.h"
#import "XPDrawerButton.h"
#import "XPDrawerViewController.h"

@interface XPLeftDrawerViewController ()

@property (nonatomic, strong) NSArray *modelList;

@end

@implementation XPLeftDrawerViewController

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
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backImage.image = [UIImage imageNamed:@"background"];
    [self.view addSubview:backImage];
    [self initModelsAndButtons];
}

- (void)initModelsAndButtons{
    self.modelList = @[[[XPDrawerModel alloc] initDrawerModelWithTitle:@"News" className:@"XPNewsViewController" imageName:@"news"],
                       [[XPDrawerModel alloc] initDrawerModelWithTitle:@"Subscription" className:@"XPSubscriptionViewController" imageName:@"subscription"],
                       [[XPDrawerModel alloc] initDrawerModelWithTitle:@"Local" className:@"XPLocalViewController" imageName:@"local"],
                       [[XPDrawerModel alloc] initDrawerModelWithTitle:@"Image" className:@"XPImageViewController" imageName:@"image"],
                       [[XPDrawerModel alloc] initDrawerModelWithTitle:@"Comment" className:@"XPCommentViewController" imageName:@"comment"],
                       [[XPDrawerModel alloc] initDrawerModelWithTitle:@"Topic" className:@"XPTopicViewController" imageName:@"topic"]];
    
    for (XPDrawerModel *model in self.modelList) {
        XPDrawerButton *btn = [XPDrawerButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:model.title forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:model.imageName] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:20];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(chooseTheModel:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = [self.modelList indexOfObject:model];

        btn.frame = CGRectMake(0, 40 + [self.modelList indexOfObject:model] * 80, 200, 80);
        [self.view addSubview:btn];
    }
}

- (void)chooseTheModel:(UIButton *)sender{
    XPDrawerModel *model = [self.modelList objectAtIndex:sender.tag];
    [[XPDrawerViewController sharedController] showContentControllerWithModel:model];
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
