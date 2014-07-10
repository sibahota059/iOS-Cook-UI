//
//  UIView+Category.m
//  iOS-Cook-UI
//
//  Created by XP on 5/31/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Category)

- (UIImage *)screenshot{
    UIGraphicsBeginImageContext(self.bounds.size);
    if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    }else{
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageData = UIImageJPEGRepresentation(image, 0.75);
    image = [UIImage imageWithData:imageData];
    return image;
}

@end
