//
//  XPContentScrollView.h
//  iOS-Cook-UI
//
//  Created by XP on 4/1/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XPAnimateTabViewController;
@interface XPContentScrollView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *contentNameArray;
@property (nonatomic, weak) XPAnimateTabViewController *mainViewController;
@property (nonatomic) NSInteger selectedTabItem;

- (void)initContentView;

@end
