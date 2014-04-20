//
//  XPPhotoLoadingView.m
//  iOS-Cook-UI
//
//  Created by XP on 4/20/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import "XPPhotoLoadingView.h"
#import "XPProgressView.h"



@interface XPPhotoLoadingView ()

@property (nonatomic, strong) UILabel *failureLabel;
@property (nonatomic, strong) XPProgressView *progressView;


@end

@implementation XPPhotoLoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)showFailure{
    [self.progressView removeFromSuperview];
    [self.progressView removeFromSuperview];

    [self.failureLabel removeFromSuperview];
    self.failureLabel = [[UILabel alloc] init];
    self.failureLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, 44);
    self.failureLabel.textAlignment = NSTextAlignmentCenter;
    self.failureLabel.text = @"网络不给力，图片加载失败";
    self.failureLabel.font = [UIFont boldSystemFontOfSize:20];
    self.failureLabel.textColor = [UIColor whiteColor];
    self.failureLabel.backgroundColor = [UIColor clearColor];
    self.failureLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    self.failureLabel.center = [self convertPoint:self.center fromView:self.superview];
    [self addSubview:self.failureLabel];
}

- (void)showLoading{
    [self.failureLabel removeFromSuperview];
    [self.progressView removeFromSuperview];
    
    self.progressView = [[XPProgressView alloc] init];
    self.progressView.bounds = CGRectMake(0, 0, 60, 60);
    self.progressView.center = [self convertPoint:self.center fromView:self.superview];
    self.progressView.progress = kMinProgress;
    [self addSubview:self.progressView];
}

-(void)setProgress:(float)progress{
    _progress = progress;
    self.progressView.progress = progress;
    if (progress >= 1.0) {
        [self.progressView removeFromSuperview];
    }
}

@end
