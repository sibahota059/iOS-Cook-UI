//
//  XPSoundManager.h
//  iOS-Cook-UI
//
//  Created by XP on 5/31/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XPSoundManager : NSObject

+ (instancetype)soundManager;

-(void)playSound:(NSURL *)url;

@end
