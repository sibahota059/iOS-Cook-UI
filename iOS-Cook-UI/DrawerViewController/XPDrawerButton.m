//
//  XPDrawerButton.m
//  iOS-Cook-UI
//
//  Created by XP on 3/26/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import "XPDrawerButton.h"

@implementation XPDrawerButton

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(60, 0, contentRect.size.width - 50, contentRect.size.height);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(30, contentRect.size.height * 0.5 - 12, 24, 24);
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
