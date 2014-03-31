//
//  XPHUD.h
//  iOS-Cook-UI
//
//  Created by XP on 3/27/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XPHUDType){
    XPHUDTypeActivityIndicatorOnly = 0,
    XPHUDTypeCaptionOnly,
    XPHUDTypeCustomImageOnly,
    XPHUDTypeActivityWithCaption
};

@interface XPHUD : UIView

- (instancetype)initWithTitle:(NSString *)title type:(XPHUDType)type image:(UIImage *)image;
- (void)showInView:(UIView *)superView;
- (void)showInView:(UIView *)superView hideAfter:(NSTimeInterval)delay;
- (void)showWhileExecuting:(SEL)selector onTarget:(id)target withObject:(id)object inView:(UIView *)superView;
- (void)showWhileExecutingBlock:(dispatch_block_t)block completionBlock:(dispatch_block_t)completion inView:(UIView *)superView;
- (void)remove;

@end
