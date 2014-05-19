//
//  XPSubscribeButton.h
//  iOS-Cook-UI
//
//  Created by XP on 5/15/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XPSubscribeButton : UIButton

@property (nonatomic, strong) UIViewController *vc;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *urlStringArray;

+ (instancetype)subscribeButtonWithViewController:(UIViewController *)vc titleArray:(NSArray *)titleArray urlStringArray:(NSArray *)urlStringArray;

@end
