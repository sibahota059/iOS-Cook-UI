//
//  XPPhoto.m
//  iOS-Cook-UI
//
//  Created by XP on 4/8/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import "XPPhoto.h"

@interface XPPhoto ()

@end

@implementation XPPhoto

-(instancetype)initWithImage:(UIImage *)image{
    self = [super init];
    if (self) {
        _image = image;
    }
    return self;
}

- (instancetype)initWithURL:(NSURL *)url{
    self = [super init];
    if (self) {
        _photoURL = url;
    }
    return self;
}

+(XPPhoto *)photoWithImage:(UIImage *)image{
    return [[XPPhoto alloc] initWithImage:image];
}

+(XPPhoto *)photoWithFilePath:(NSString *)path{
    return [[XPPhoto alloc] initWithURL:[NSURL fileURLWithPath:path]];
}

+(XPPhoto *)photoWithURL:(NSURL *)url{
    return [[XPPhoto alloc] initWithURL:url];
}

@end
