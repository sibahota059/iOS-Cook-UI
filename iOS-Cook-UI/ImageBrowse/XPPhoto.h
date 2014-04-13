//
//  XPPhoto.h
//  iOS-Cook-UI
//
//  Created by XP on 4/13/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XPPhoto : NSObject

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong, readonly) UIImage *holderImage;

@end
