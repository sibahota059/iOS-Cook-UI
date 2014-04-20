//
//  XPPhotoLoadingView.h
//  iOS-Cook-UI
//
//  Created by XP on 4/20/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMinProgress 0.01

@interface XPPhotoLoadingView : UIView

@property (nonatomic) float progress;

- (void)showLoading;
- (void)showFailure;

@end
