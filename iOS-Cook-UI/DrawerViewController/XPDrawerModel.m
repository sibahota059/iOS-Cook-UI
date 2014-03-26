//
//  XPDrawerModel.m
//  iOS-Cook-UI
//
//  Created by XP on 3/25/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import "XPDrawerModel.h"

@implementation XPDrawerModel

- (instancetype)initDrawerModelWithTitle:(NSString *)title className:(NSString *)className imageName:(NSString *)imageName{
    self = [super init];
    if (self) {
        self.title = title;
        self.className = className;
        self.imageName = imageName;
    }
    return self;
}

@end
