//
//  UILabel+Category.m
//  iOS-Cook-UI
//
//  Created by XP on 3/31/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import "UILabel+Category.h"

@implementation UILabel (Category)

+ (CGFloat)getTextWidth:(NSString *)text fontSize:(CGFloat)size{
    CGSize textSize = [text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]}];
    return textSize.width;
}

@end
