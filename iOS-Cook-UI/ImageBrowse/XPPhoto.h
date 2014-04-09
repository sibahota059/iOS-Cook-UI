//
//  XPPhoto.h
//  iOS-Cook-UI
//
//  Created by XP on 4/8/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XPPhoto : NSObject

@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSURL *photoURL;

+(XPPhoto *)photoWithImage:(UIImage *)image;
+(XPPhoto *)photoWithFilePath:(NSString *)path;
+(XPPhoto *)photoWithURL:(NSURL *)url;

@end
