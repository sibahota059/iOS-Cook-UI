//
//  XPMenu.m
//  iOS-Cook-UI
//
//  Created by XP on 5/15/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import "XPMenu.h"

@implementation XPMenu

- (instancetype)initWIthTitle:(NSString *)title urlString:(NSString *)urlString{
    if (self = [super init]) {
        self.title = title;
        self.urlString = urlString;
    }
    return  self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.urlString = [aDecoder decodeObjectForKey:@"urlString"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.urlString forKey:@"urlString"];
}

@end
