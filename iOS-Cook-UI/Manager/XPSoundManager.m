//
//  XPSoundManager.m
//  iOS-Cook-UI
//
//  Created by XP on 5/31/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import "XPSoundManager.h"
#import <AudioToolbox/AudioToolbox.h>

@interface XPSoundManager ()

@end

@implementation XPSoundManager

+ (instancetype)soundManager{
    static XPSoundManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XPSoundManager alloc] init];
    });
    return instance;
}

-(void)playSound:(NSURL *)url{
    SystemSoundID refreshSound;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &refreshSound);
    AudioServicesPlaySystemSound(refreshSound);
    AudioServicesDisposeSystemSoundID(refreshSound);
}

@end
