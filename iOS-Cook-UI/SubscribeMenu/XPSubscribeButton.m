//
//  XPSubscribeButton.m
//  iOS-Cook-UI
//
//  Created by XP on 5/15/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import "XPSubscribeButton.h"

@implementation XPSubscribeButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (instancetype)subscribeButtonWithViewController:(UIViewController *)vc titleArray:(NSArray *)titleArray urlStringArray:(NSArray *)urlStringArray{
    XPSubscribeButton *button = [XPSubscribeButton buttonWithType:UIButtonTypeCustom];
    [button setVc:vc];
    [button setTitleArray:titleArray];
    [button setUrlStringArray:urlStringArray];
    [button setImage:[UIImage imageNamed:@"subscribeBtn"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"subscribeBtn_hl"] forState:UIControlStateHighlighted];
    return button;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
