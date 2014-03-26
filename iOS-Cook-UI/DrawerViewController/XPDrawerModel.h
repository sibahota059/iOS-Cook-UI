//
//  XPDrawerModel.h
//  iOS-Cook-UI
//
//  Created by XP on 3/25/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XPDrawerModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *className;
@property (nonatomic, strong) NSString *imageName;

- (instancetype)initDrawerModelWithTitle:(NSString *)title className:(NSString *)className imageName:(NSString *)imageName;

@end
