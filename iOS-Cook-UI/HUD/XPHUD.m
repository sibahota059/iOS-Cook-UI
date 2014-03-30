//
//  XPHUD.m
//  iOS-Cook-UI
//
//  Created by XP on 3/27/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import "XPHUD.h"

#define kWidthPercent 0.3

@interface XPHUD ()

@property (nonatomic, strong) NSString *title;
@property (nonatomic) XPHUDType type;
@property (nonatomic, strong) UIImage *image;

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
    switch (self.type) {
        case XPHUDTypeActiveOnly:
        {
            [self showActivityOnly:superView];
        }
            break;
            
        default:
            break;
    }
}

- (void)remove{
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
- (void)showActivityOnly:(UIView *)superView{
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

@end
