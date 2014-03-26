//
//  XPDrawerViewController.m
//  iOS-Cook-UI
//
//  Created by XP on 3/25/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import "XPDrawerViewController.h"
#import "XPLeftDrawerViewController.h"
#import "XPRightDrawerViewController.h"

#define kContentOffset 220
#define kContentScale 0.9

static XPDrawerViewController *shareController;

@interface XPDrawerViewController ()

@property (nonatomic, strong) NSMutableDictionary *controllerDictionary;
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

@end

@implementation XPDrawerViewController

+ (XPDrawerViewController *)sharedController{
    return shareController;
}

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
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{shareController = self;});
    
    self.controllerDictionary = [NSMutableDictionary dictionary];
    
    [self initSubViews];
    [self initChildViewControllers];
    [self showContentControllerWithModel:[[XPDrawerModel alloc] initDrawerModelWithTitle:@"News" className:@"XPNewsViewController" imageName:@"News"]];
    
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeDrawer)];
    [self.view addGestureRecognizer:self.tapGesture];
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGesture:)];
    [self.mainView addGestureRecognizer:self.panGesture];
}

- (void)initChildViewControllers{
    XPLeftDrawerViewController *leftDrawer = [[XPLeftDrawerViewController alloc] init];
    [self addChildViewController:leftDrawer];
    [self.leftView addSubview:leftDrawer.view];
    
    XPRightDrawerViewController *rightDrawer = [[XPRightDrawerViewController alloc] init];
    [self addChildViewController:rightDrawer];
    [self.rightView addSubview:rightDrawer.view];
}

- (void)initSubViews{
    UIView *rightView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:rightView];
    self.rightView = rightView;
    UIView *leftView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:leftView];
    self.leftView = leftView;
    UIView *mainvView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:mainvView];
    self.mainView = mainvView;
}


#pragma mark - show child view controller
- (void)showContentControllerWithModel:(XPDrawerModel *)model{
    [self closeDrawer];
    
    UINavigationController *controller = self.controllerDictionary[model.className];
    if (!controller) {
        Class c = NSClassFromString(model.className);
        UIViewController *vc = [[c alloc] init];
        vc.view.backgroundColor = [UIColor darkGrayColor];
        controller = [[UINavigationController alloc] initWithRootViewController:vc];
        controller.navigationBar.barTintColor = [UIColor darkGrayColor];
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(0, 0, 100, 44);
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:22];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = model.title;
        
        UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"toggle"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemClicked)];
        UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"toggle"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClicked)];
        
        vc.navigationItem.leftBarButtonItem = leftBarButtonItem;
        vc.navigationItem.rightBarButtonItem = rightBarButtonItem;
        vc.navigationItem.titleView = titleLabel;
        
        [self.controllerDictionary setObject:controller forKey:model.className];
        [self addChildViewController:controller];
    }
    
    if (self.mainView.subviews.count > 0) {
        UIView *view = [self.mainView.subviews firstObject];
        [view removeFromSuperview];
    }
    
    controller.view.frame = self.mainView.frame;
    [self.mainView addSubview:controller.view];
    
}

- (void)leftBarButtonItemClicked{
    CGAffineTransform transform = [self transformToRight];
    [self.view sendSubviewToBack:self.rightView];
    [self configureRightViewShadow];
    
    [UIView animateWithDuration:1.0 animations:^{
        self.mainView.transform = transform;
    } completion:^(BOOL finished){
        self.tapGesture.enabled = YES;
        [self disableMainviewUserInteraction];
    }];
}

- (void)rightBarButtonItemClicked{
    CGAffineTransform transform = [self transformToLeft];
    [self.view sendSubviewToBack:self.leftView];
    [self configureLeftViewShadow];
    
    [UIView animateWithDuration:1 animations:^{
        self.mainView.transform = transform;
    } completion:^(BOOL finished){
        self.tapGesture.enabled = YES;
        [self disableMainviewUserInteraction];
    }];
}

- (void)closeDrawer{
    [UIView animateWithDuration:1 animations:^{
        self.mainView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished){
        self.tapGesture.enabled = NO;
        [self enableMainviewUserInteraction];
    }];
}

- (void)moveViewWithGesture:(UIPanGestureRecognizer *)panGesture{
    static CGFloat currentTranslateX;
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        currentTranslateX = self.mainView.transform.tx;
    }
    if (panGesture.state == UIGestureRecognizerStateChanged) {
        CGFloat transX = [panGesture translationInView:self.mainView].x;
        transX = transX + currentTranslateX;
        
        CGFloat scal;
        if (transX > 0) {
            [self.view sendSubviewToBack:self.rightView];
            [self configureRightViewShadow];
            if (self.mainView.frame.origin.x < kContentOffset) {
                scal = 1 - (self.mainView.frame.origin.x / kContentOffset) * (1 - kContentScale);
            }else{
                scal = kContentScale;
            }
        }else{
            [self.view sendSubviewToBack:self.leftView];
            [self configureLeftViewShadow];
            if (self.mainView.frame.origin.x >  - kContentOffset) {
                scal = 1 - (-self.mainView.frame.origin.x / kContentOffset) * (1 - kContentScale);
            }else{
                scal = kContentScale;
            }
        }
        
        CGAffineTransform trans = CGAffineTransformMakeScale(1.0, scal);
        CGAffineTransform transScale = CGAffineTransformMakeTranslation(transX, 0);
        CGAffineTransform transform = CGAffineTransformConcat(trans, transScale);
        
        self.mainView.transform = transform;
    }else if(panGesture.state == UIGestureRecognizerStateEnded){
        CGFloat panX = [panGesture translationInView:self.mainView].x;
        CGFloat finalX = currentTranslateX + panX;
        if (finalX > kContentOffset * 0.5) {
            CGAffineTransform transform = [self transformToRight];
            [UIView beginAnimations:nil context:nil];
            self.mainView.transform = transform;
            [UIView commitAnimations];
            self.tapGesture.enabled = YES;
            [self disableMainviewUserInteraction];
        }else if(finalX < - kContentOffset * 0.5){
            CGAffineTransform transform = [self transformToLeft];
            [UIView beginAnimations:nil context:nil];
            self.mainView.transform = transform;
            [UIView commitAnimations];
            self.tapGesture.enabled = YES;
            [self disableMainviewUserInteraction];
        }else{
            CGAffineTransform transform = CGAffineTransformIdentity;
            [UIView beginAnimations:nil context:nil];
            self.mainView.transform = transform;
            [UIView commitAnimations];
            self.tapGesture.enabled = NO;
            [self enableMainviewUserInteraction];
        }
    }
}

#pragma mark - disable and enable Mainview UserInteraction
-(void)disableMainviewUserInteraction{
//    [self.mainView setUserInteractionEnabled:NO];
    [self disableUserInteraction:self.mainView];
}

- (void)disableUserInteraction:(UIView *)view{
    if (view.subviews.count > 0) {
        for (UIView *subview in view.subviews) {
            [subview setUserInteractionEnabled:NO];
        }
    }
}

-(void)enableMainviewUserInteraction{
//    [self enableUserInteraction:self.mainView];
    [self enableUserInteraction:self.mainView];
}

- (void)enableUserInteraction:(UIView *)view{
    if (view.subviews.count > 0) {
        for (UIView *subview in view.subviews) {
            [subview setUserInteractionEnabled:YES];
        }
    }
}

#pragma mark - prepare transformation
- (CGAffineTransform)transformToRight{
    CGAffineTransform trans = CGAffineTransformMakeTranslation(kContentOffset, 0);
    CGAffineTransform scale = CGAffineTransformMakeScale(1.0, kContentScale);
    CGAffineTransform con = CGAffineTransformConcat(trans, scale);
    return con;
}

- (CGAffineTransform)transformToLeft{
    CGAffineTransform trans = CGAffineTransformMakeTranslation(-kContentOffset, 0);
    CGAffineTransform scale = CGAffineTransformMakeScale(1.0, kContentScale);
    CGAffineTransform con = CGAffineTransformConcat(trans, scale);
    return con;
}

- (void)configureRightViewShadow{
    self.mainView.layer.shadowOffset = CGSizeMake(-2.0, 1.0);
    self.mainView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.mainView.layer.shadowOpacity = 0.8;
}

- (void)configureLeftViewShadow{
    self.mainView.layer.shadowOffset = CGSizeMake(2.0, 2.0);
    self.mainView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.mainView.layer.shadowOpacity = 0.8;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
