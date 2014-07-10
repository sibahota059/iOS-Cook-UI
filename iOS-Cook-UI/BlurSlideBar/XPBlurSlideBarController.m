//
//  XPBlurSlideBar.m
//  iOS-Cook-UI
//
//  Created by XP on 3/19/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import "XPBlurSlideBarController.h"
#import "XPCategory.h"


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

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat inset = self.bounds.size.height * 0.5;
    self.imageView.frame = CGRectMake(0, 0, inset, inset);
    self.imageView.center = CGPointMake(inset, inset);
}

- (void)setOriginalBackgroundColor:(UIColor *)originalBackgroundColor{
    _originalBackgroundColor = originalBackgroundColor;
    self.backgroundColor = originalBackgroundColor;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    CGFloat r, g, b, a;
    float darkenFactor = 0.3;
    UIColor *darkerColor;
    if ([self.originalBackgroundColor getRed:&r green:&g blue:&b alpha:&a]) {
        darkerColor = [UIColor colorWithRed:MAX(r - darkenFactor, 0.0) green:MAX(g - darkenFactor, 0.0) blue:MAX(b - darkenFactor, 0.0) alpha:a];
    }else if([self.originalBackgroundColor getWhite:&r alpha:&a]){
        darkerColor = [UIColor colorWithWhite:MAX(r - darkenFactor, 0.0) alpha:a];
    }else{
    
    }
    self.backgroundColor = darkerColor;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    self.backgroundColor = self.originalBackgroundColor;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    self.backgroundColor = self.originalBackgroundColor;
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
@property (nonatomic, strong) UIImageView *blurView;

@end

static XPBlurSlideBarController *frostedMenu;

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
        
        [self.images enumerateObjectsUsingBlock:^(UIImage *image, NSUInteger index, BOOL *stop) {
            SlideBarItemView *view = [[SlideBarItemView alloc] init];
            view.itemIndex = index;
            view.clipsToBounds = YES;
            view.imageView.image = image;
            [self.contentView addSubview:view];
            
            [self.itemViews addObject:view];
            
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

- (void)loadView{
    [super loadView];
    
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.contentView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer{
    CGPoint location = [recognizer locationInView:self.view];
    if (! CGRectContainsPoint(self.contentView.frame, location)) {
        [self dismissAnimated:YES completion:nil];
    }else{
        NSInteger tapIndex = [self indexOfTap:[recognizer locationInView:self.contentView]];
        if (tapIndex != NSNotFound) {
            [self didTapItemAtIndex:tapIndex];
        }
    }
}

- (void)didTapItemAtIndex:(NSUInteger)index{
    BOOL didEnable = ![self.selectedIndices containsIndex:index];
    
    if (self.borderColors) {
        UIColor *stroke = self.borderColors[index];
        UIView *view = self.itemViews[index];
        
        if (didEnable) {
            if (self.isSingleSelect) {
                [self.selectedIndices removeAllIndexes];
                [self.itemViews enumerateObjectsUsingBlock:^(id obj, NSUInteger inx, BOOL *stop){
                    UIView *aView = (UIView *)obj;
                    [[aView layer] setBorderColor:[[UIColor clearColor] CGColor]];
                }];
            }
            view.layer.borderColor = stroke.CGColor;
            CABasicAnimation *borderAnimation = [CABasicAnimation animationWithKeyPath:@"borderColor"];
            borderAnimation.fromValue = (id)[UIColor clearColor].CGColor;
            borderAnimation.toValue = (id)stroke.CGColor;
            borderAnimation.duration = 0.5;
            [view.layer addAnimation:borderAnimation forKey:nil];
            [self.selectedIndices addIndex:index];
        }else{
            if (!self.isSingleSelect) {
                view.layer.borderColor = [UIColor clearColor].CGColor;
                [self.selectedIndices removeIndex:index];
            }
        }
        
        CGRect pathFrame = CGRectMake(-CGRectGetMidX(view.bounds), -CGRectGetMidY(view.bounds), view.bounds.size.width, view.bounds.size.height);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathFrame cornerRadius:view.layer.cornerRadius];
        CGPoint shapePosition = [self.view convertPoint:view.center fromView:self.contentView];
        CAShapeLayer *circleShape = [CAShapeLayer layer];
        circleShape.path = path.CGPath;
        circleShape.position = shapePosition;
        circleShape.fillColor = [UIColor clearColor].CGColor;
        circleShape.opacity = 0;
        circleShape.strokeColor = stroke.CGColor;
        circleShape.lineWidth = self.borderWidth;
        [self.view.layer addSublayer:circleShape];
        
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(2.5, 2.5, 1)];
        
        CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        alphaAnimation.fromValue = @1;
        alphaAnimation.toValue = @0;
        
        CAAnimationGroup *animation = [CAAnimationGroup animation];
        animation.animations = @[scaleAnimation, alphaAnimation];
        animation.duration = 0.5f;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        [circleShape addAnimation:animation forKey:nil];
    }
    
    [self.delegate slideBar:self didTapItemAtIndex:index];
    [self.delegate slideBar:self didEnable:didEnable itemAtIndex:index];
}

- (NSInteger)indexOfTap:(CGPoint)location{
    __block NSUInteger index = NSNotFound;
    [self.itemViews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop){
        if (CGRectContainsPoint(view.frame, location)) {
            index = idx;
            *stop = YES;
        }
    }];
    return index;
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

- (void)animateFauxBounceWithView:(SlideBarItemView *)view index:(NSUInteger)index initDelay:(CGFloat)initDelay{
    [UIView animateWithDuration:0.2
                          delay:(initDelay + index * 0.1f)
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationCurveEaseInOut
                     animations:^{
                         view.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1);
                         view.alpha = 1;
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.1
                         animations:^{
                             view.layer.transform = CATransform3DIdentity;
                         }];
        }];
}

- (void)animateSpringWithView:(SlideBarItemView *)view index:(NSUInteger)index initDelay:(CGFloat)initDelay{
    [UIView animateWithDuration:0.5
                          delay:(initDelay + index*0.1f)
         usingSpringWithDamping:10
          initialSpringVelocity:50
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         view.layer.transform = CATransform3DIdentity;
                        view.alpha = 1;
                     }
                     completion:nil];
}

- (void)layoutItems{
    CGFloat leftPadding = (self.width - self.itemSize.width) / 2;
    CGFloat topPadding = leftPadding;
    [self.itemViews enumerateObjectsUsingBlock:^(SlideBarItemView *view, NSUInteger index, BOOL *stop){
        CGRect frame = CGRectMake(leftPadding, topPadding * index + self.itemSize.height * index + topPadding, self.itemSize.width , self.itemSize.height);
        view.frame = frame;
        view.layer.cornerRadius = frame.size.width * 0.5;
    }];
    
    NSInteger items = [self.itemViews count];
    self.contentView.contentSize = CGSizeMake(0, items * (self.itemSize.height + leftPadding) + leftPadding);
}

#pragma mark - show
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
    if (frostedMenu != nil) {
        [frostedMenu dismissAnimated:NO completion:nil];
    }
    
    [self.delegate slideBar:self willShowOnScreenAnimated:animated];
    
    frostedMenu = self;
    
    UIImage *blurImage = [controller.view screenshot];
    blurImage = [blurImage applyBlurWithRadius:5 tintColor:self.tintColor saturationDeltaFactor:1.8 maskImage:nil];
    
    if (self.parentViewController) {
        [self beginAppearanceTransition:NO animated:YES];
        [self willMoveToParentViewController:nil];
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
        [self endAppearanceTransition];
    }
    
    [self beginAppearanceTransition:YES animated:YES];
    [controller addChildViewController:self];
    [controller.view addSubview:self.view];
    [self didMoveToParentViewController:self];
    [self endAppearanceTransition];
    
    self.view.frame = controller.view.bounds;
    CGRect contentFrame = self.view.bounds;
    contentFrame.origin.x = self.showFromRight ? self.view.bounds.size.width : - self.width;
    contentFrame.size.width = self.width;
    self.contentView.frame = contentFrame;
    
    [self layoutItems];
    
    CGRect blurFrame = CGRectMake(self.showFromRight ? self.view.bounds.size.width : 0, 0, 0, self.view.bounds.size.height);
    self.blurView = [[UIImageView alloc] initWithImage:blurImage];
    self.blurView.frame = blurFrame;
    self.blurView.clipsToBounds = YES;
    self.blurView.contentMode = self.showFromRight ? UIViewContentModeTopRight : UIViewContentModeTopLeft;
    [self.view insertSubview:self.blurView belowSubview:self.contentView];
    
    contentFrame.origin.x = self.showFromRight ? controller.view.bounds.size.width - self.width : 0;
    blurFrame.origin.x = contentFrame.origin.x;
    blurFrame.size.width = self.width;
    
    void (^animations)() = ^{
        self.contentView.frame = contentFrame;
        self.blurView.frame = blurFrame;
    };
    
    void (^completion)(BOOL) = ^(BOOL finished){
        if (finished) {
            [self.delegate slideBar:self didShowOnScreenAnimated:animated];
        }
    };
    
    if (animated) {
        [UIView animateWithDuration:self.animationDuration
                              delay:0
                            options:kNilOptions
                         animations:animations
                         completion:completion];
    }else{
        animations();
        completion(YES);
    }
    
    CGFloat initDelay = 0.1f;
    SEL sdkSpringSelector = NSSelectorFromString(@"animateWithDuration:delay:usingSpringWithDamping:initialSpringVelocity:options:animations:completion:");
    BOOL sdkHasSpringAnimation = [UIView respondsToSelector:sdkSpringSelector];
    
    [self.itemViews enumerateObjectsUsingBlock:^(SlideBarItemView *view, NSUInteger index, BOOL *stop){
        view.layer.transform = CATransform3DMakeScale(0.3, 0.3, 1);
        view.alpha = 0;
        view.originalBackgroundColor = self.itemBackgroundColor;
        view.layer.borderWidth = self.borderWidth;
        
        if (sdkHasSpringAnimation) {
            [self animateSpringWithView:view index:index initDelay:initDelay];
        }else{
            [self animateFauxBounceWithView:view index:index initDelay:initDelay];
        }
    }];
}

#pragma mark - dismiss
- (void)dismiss{
    [self dismissAnimated:YES completion:nil];
}

- (void)dismissAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion{
    void (^completionBlock)(BOOL) = ^(BOOL finished){
        [self beginAppearanceTransition:NO animated:YES];
        [self willMoveToParentViewController:nil];
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
        [self endAppearanceTransition];
        
        [self.delegate slideBar:self DidDismissFromScreenAnimated:YES];
        
        if (completion) {
            completion(finished);
        }
    };
    
    if (animated) {
        CGFloat parentWidth = self.view.bounds.size.width;
        CGRect contentFrame = self.contentView.frame;
        contentFrame.origin.x = self.showFromRight ? parentWidth : -self.width;
        
        CGRect blurFrame = self.blurView.frame;
        blurFrame.origin.x = self.showFromRight ? parentWidth : 0;
        blurFrame.size.width = 0;
        
        [UIView animateWithDuration:self.animationDuration delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.contentView.frame = contentFrame;
            self.blurView.frame = blurFrame;
        } completion:completionBlock];
    }
    else{
        completionBlock(YES);
    }
}

@end


