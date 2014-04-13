//
//  XPPhotoBrowser.m
//  iOS-Cook-UI
//
//  Created by XP on 4/13/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import "XPPhotoBrowser.h"

#define kPadding 10

@interface XPPhotoBrowser ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) XPPhotoToolbar *toolBar;
@property (nonatomic, strong) NSMutableSet *reusablePhotoViews;

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

- (void)loadView{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    self.view = [[UIView alloc] init];
    self.view.frame = [UIScreen mainScreen].bounds;
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadScrollView];
    [self loadToolbar];
}

- (void)loadToolbar{
    CGFloat barHeight = 44;
    CGFloat barY = self.view.frame.size.height - barHeight;
    self.toolBar = [[XPPhotoToolbar alloc] initWithFrame:CGRectMake(0, barY, self.view.frame.size.width, barHeight)];
    self.toolBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.toolBar.totalPhotoCount = self.photos.count;
    [self.view addSubview:self.toolBar];
    
    [self updateToolbarState];
}

- (void)updateToolbarState{
    self.currentIndex = self.scrollView.contentOffset.x / self.scrollView.frame.size.width;
    self.toolBar.currentIndex = self.currentIndex;
}

- (void)loadScrollView{
    CGRect frame = self.view.bounds;
    frame.origin.x -= kPadding;
    frame.size.width += (2*kPadding);
    self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.contentSize = CGSizeMake(frame.size.width * self.photos.count, 0);
    [self.view addSubview:self.scrollView];
    self.scrollView.contentOffset = CGPointMake(self.currentIndex * self.view.frame.size.width, 0);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window.rootViewController addChildViewController:self];
    [window.rootViewController.view addSubview:self.view];
    [self didMoveToParentViewController:window.rootViewController];
    
    [self showPhotoAtIndex:self.currentIndex];
}

- (void)showPhotoAtIndex:(NSInteger)index{
    CGRect frame = self.scrollView.bounds;
    XPPhotoView *photoView = [[XPPhotoView alloc] initWithFrame:frame];
    frame.size.width -= (2*kPadding);
    frame.origin.x = (self.view.bounds.size.width * index) + kPadding;
    photoView.tag = index;
    XPPhoto *photo = [self.photos objectAtIndex:index];
    photoView.photo = photo;
    
    [self.scrollView addSubview:photoView];
}
@end
