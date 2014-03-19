//
//  XPBlurSlideBar.m
//  iOS-Cook-UI
//
//  Created by XP on 3/19/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import "XPBlurSlideBarController.h"

#pragma mark - Private Class

@interface SlideBarItemView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic) NSUInteger itemIndex;
@property (nonatomic, strong) UIColor *originalBackgroundColor;

@end

static SlideBarItemView *frostedSlideBlar;

@implementation SlideBarItemView

- (instancetype)init{
    if (self = [super init]) {
        self.imageView = [[UIImageView alloc] init];
        self.imageView.backgroundColor = [UIColor clearColor];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.imageView];
    }
    return self;
}

@end


@interface XPBlurSlideBarController ()

@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat animationDuration;
@property (nonatomic) CGSize itemSize;
@property (nonatomic, strong) NSMutableArray *itemViews;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic) NSUInteger borderWidth;
@property (nonatomic, strong) UIColor *itemBackgroundColor;
@property (nonatomic, strong) NSMutableIndexSet *selectedIndices;
@property (nonatomic, strong) NSArray *borderColors;
@property (nonatomic, strong) NSArray *images;

@end



@implementation XPBlurSlideBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (instancetype)initWithImages:(NSArray *)images selectedIndices:(NSIndexSet *)selectedIndices borderColors:(NSArray *)colors{
    if (self = [super init]) {
        self.isSingleSelect = NO;
        
        self.contentView = [[UIScrollView alloc] init];
        self.contentView.alwaysBounceHorizontal = NO;
        self.contentView.alwaysBounceVertical = YES;
        self.contentView.bounces = YES;
        self.contentView.clipsToBounds = NO;
        self.contentView.showsHorizontalScrollIndicator = NO;
        self.contentView.showsVerticalScrollIndicator = NO;
        
        self.width = 150;
        self.animationDuration = 0.25f;
        self.itemSize = CGSizeMake(self.width * 0.5, self.width * 0.5);
        self.itemViews = [NSMutableArray array];
        self.tintColor = [UIColor colorWithWhite:0.2 alpha:0.73];
        self.borderWidth = 2;
        self.itemBackgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.25];
        
        if (colors) {
            NSAssert(colors.count == images.count,@"Border color count must match images count, if you want a blank border, use [UIColor clearColor]");
        }
        
        self.selectedIndices = [selectedIndices mutableCopy] ? : [NSMutableIndexSet indexSet];
        self.borderColors = colors;
        self.images = images;
        
        [_images enumerateObjectsUsingBlock:^(UIImage *image, NSUInteger index, BOOL *stop) {
            SlideBarItemView *view = [[SlideBarItemView alloc] init];
            view.itemIndex = index;
            view.clipsToBounds = YES;
            view.imageView.image = image;
            [self.contentView addSubview:view];
            
            if (self.borderColors && self.selectedIndices && [self.selectedIndices containsIndex:index]) {
                UIColor *color = self.borderColors[index];
                view.layer.borderColor = color.CGColor;
            }else{
                view.layer.borderColor = [UIColor clearColor].CGColor;
            }
        }];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)show{
    [self showAnimated:YES];
}

- (void)showAnimated:(BOOL)animated{
    UIViewController *controller = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (controller.presentedViewController != nil) {
        controller = controller.presentedViewController;
    }
    [self showInViewController:controller animated:animated];
}

- (void)showInViewController:(UIViewController *)controller animated:(BOOL)animated{
    if (<#condition#>) {
        <#statements#>
    }
}

@end


