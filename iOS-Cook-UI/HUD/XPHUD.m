//
//  XPHUD.m
//  iOS-Cook-UI
//
//  Created by XP on 3/27/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import "XPHUD.h"

#define kWidthPercent 0.3
#define kCaptionHeight 30

@interface XPHUD ()

@property (nonatomic, strong) NSString *title;
@property (nonatomic) XPHUDType type;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, weak) UIView *superView;

@property SEL methodForExecution;
@property id targetForExecution;
@property id objectForExecution;

@end

@implementation XPHUD

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title type:(XPHUDType)type image:(UIImage *)image{
    self = [super init];
    if (self) {
        self.title = title;
        self.type = type;
        self.image = image;
    }
    return self;
}

- (void)showInView:(UIView *)superView{
    self.superView = superView;
    [self.superView setUserInteractionEnabled:NO];
    switch (self.type) {
        case XPHUDTypeActivityIndicatorOnly:
        {
            [self showActivityIndicatorOnly:superView];
        }
            break;
        case XPHUDTypeCaptionOnly:
        {
            [self showCaptionOnly:superView];
        }
            break;
        case XPHUDTypeCustomImageOnly:
        {
            [self showCustomImageOnly:superView];
        }
            break;
        default:
            break;
    }
}

- (void)remove{
    [self.superView setUserInteractionEnabled:YES];
    [self removeFromSuperview];
}



- (void)showWhileExecuting:(SEL)selector onTarget:(id)target withObject:(id)object inView:(UIView *)superView{
    [self showInView:superView];
    self.methodForExecution = selector;
    self.targetForExecution = target;
    [NSThread detachNewThreadSelector:@selector(launchExecution) toTarget:self withObject:nil];
}

- (void)launchExecution{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self.targetForExecution performSelector:self.methodForExecution withObject:self.objectForExecution];
#pragma clang diagnostic pop
    
    [self performSelectorOnMainThread:@selector(remove) withObject:nil waitUntilDone:NO];
}

- (void)showWhileExecutingBlock:(dispatch_block_t)block completionBlock:(dispatch_block_t)completion inView:(UIView *)superView{
    [self showInView:superView];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^(void){
        block();
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [self remove];
            if (completion) {
                completion();
            }
        });
    });
}

#pragma mark - shwo activity only
- (void)showActivityIndicatorOnly:(UIView *)superView{
    self.frame = CGRectMake(0, 0, superView.bounds.size.width * kWidthPercent, superView.bounds.size.width * kWidthPercent);
    self.layer.cornerRadius = 5;
    self.center = CGPointMake(superView.bounds.size.width * 0.5, superView.bounds.size.height * 0.5);
    self.backgroundColor = [UIColor darkGrayColor];
    [superView addSubview:self];
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self addSubview:activity];
    activity.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.width * 0.5);
    [activity startAnimating];

}

- (void)showCaptionOnly:(UIView *)superView{
    self.frame = CGRectMake(0, 0, superView.bounds.size.width * kWidthPercent, kCaptionHeight);
    self.layer.cornerRadius = 5;
    self.center = CGPointMake(superView.bounds.size.width * 0.5, superView.bounds.size.height * 0.5);
    self.backgroundColor = [UIColor darkGrayColor];
    [superView addSubview:self];
    UILabel *label = [[UILabel alloc] init];
    label.text = self.title;
    [label sizeToFit];
    label.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    [self addSubview:label];
}

- (void)showCustomImageOnly:(UIView *)superView{
    self.frame = CGRectMake(0, 0, superView.bounds.size.width * kWidthPercent, superView.bounds.size.width * kWidthPercent);
    self.layer.cornerRadius = 5;
    self.center = CGPointMake(superView.bounds.size.width * 0.5, superView.bounds.size.height * 0.5);
    self.backgroundColor = [UIColor darkGrayColor];
    [superView addSubview:self];
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width * 0.6, self.frame.size.width * 0.6)];
    image.image = self.image;
    [self addSubview:image];
    image.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.width * 0.5);
}

@end
