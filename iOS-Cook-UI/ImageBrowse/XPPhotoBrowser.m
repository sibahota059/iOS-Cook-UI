//
//  XPPhotoBrowserViewController.m
//  iOS-Cook-UI
//
//  Created by XP on 4/9/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import "XPPhotoBrowser.h"

#define kPadding 10

@interface XPPhotoBrowser ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation XPPhotoBrowser

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
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.view.clipsToBounds = YES;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:[self frameForScrollView]];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.backgroundColor = [UIColor lightGrayColor];
    self.scrollView.contentSize = [self contentSizeForScrollView];
    [self.view addSubview:self.scrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - frame calculation
-(CGRect)frameForScrollView{
    CGRect frame = self.view.bounds;
    frame.origin.x -= kPadding;
    frame.size.width += (2 * kPadding);
    return CGRectIntegral(frame);
}

-(CGSize)contentSizeForScrollView{
    CGRect bounds = self.scrollView.bounds;
    return CGSizeMake(bounds.size.width * self.photos.count, bounds.size.height);
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
