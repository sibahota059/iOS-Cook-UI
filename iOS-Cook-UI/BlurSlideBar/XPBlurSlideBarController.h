//
//  XPBlurSlideBar.h
//  iOS-Cook-UI
//
//  Created by XP on 3/19/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XPBlurSlideBarController;
@protocol XPBlurSliderBarControllerDelegate <NSObject>

- (void)slideBar:(XPBlurSlideBarController *)slideBar willShowOnScreenAnimated:(BOOL)animated;
- (void)slideBar:(XPBlurSlideBarController *)slideBar didShowOnScreenAnimated:(BOOL)animated;
- (void)slideBar:(XPBlurSlideBarController *)slideBar willDismissFromScreenAnimated:(BOOL)animated;
- (void)slideBar:(XPBlurSlideBarController *)slideBar DidDismissFromScreenAnimated:(BOOL)animated;
- (void)slideBar:(XPBlurSlideBarController *)slideBar didEnable:(BOOL)itemEnabled itemAtIndex:(NSUInteger)index;
- (void)slideBar:(XPBlurSlideBarController *)slideBar didTapItemAtIndex:(NSUInteger)index;

@end

@interface XPBlurSlideBarController : UIViewController

@property (nonatomic) BOOL isSingleSelect;
@property (nonatomic) BOOL showFromRight;
@property (nonatomic, weak) id<XPBlurSliderBarControllerDelegate> delegate;

- (instancetype)initWithImages:(NSArray *)images selectedIndices:(NSIndexSet *)selectedIndices borderColors:(NSArray *)colors;
- (void)show;
- (void)dismiss;

@end
