//
//  XPTabScrollView.h
//  iOS-Cook-UI
//
//  Created by XP on 4/1/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XPAnimateTabViewController;
@interface XPTabScrollView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *tabNameArray;
@property (nonatomic, weak) XPAnimateTabViewController *mainViewController;
@property (nonatomic) NSInteger selectedTabItem;

- (void)initTabView;
- (void)selectTabItemFromContentView:(NSInteger)tag;

@end
