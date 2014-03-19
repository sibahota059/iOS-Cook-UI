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

- (void)sideBar:(XPBlurSlideBarController *)sideBar willShowOnScreenAnimated:(BOOL)animated;
- (void)sideBar:(XPBlurSlideBarController *)sideBar didShowOnScreenAnimated:(BOOL)animated;
- (void)sideBar:(XPBlurSlideBarController *)sideBar willDismissFromScreenAnimated:(BOOL)animated;
- (void)sideBar:(XPBlurSlideBarController *)sideBar willDidDismissFromScreenAnimated:(BOOL)animated;
- (void)sideBar:(XPBlurSlideBarController *)sideBar didEnable:(BOOL)itemEnabled itemAtIndex:(NSUInteger)index;

@end

@interface XPBlurSlideBarController : UIViewController

@property (nonatomic) BOOL isSingleSelect;

- (instancetype)initWithImages:(NSArray *)images selectedIndices:(NSIndexSet *)selectedIndices borderColors:(NSArray *)colors;
- (void)show;


@end
