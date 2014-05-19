//
//  XPMenu.h
//  iOS-Cook-UI
//
//  Created by XP on 5/15/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XPMenu : NSObject<NSCoding>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *urlString;

- (instancetype)initWIthTitle:(NSString *)title urlString:(NSString *)urlString;

@end
