//
//  XPDrawerViewController.h
//  iOS-Cook-UI
//
//  Created by XP on 3/25/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XPDrawerModel.h"

@interface XPDrawerViewController : UIViewController

+ (XPDrawerViewController *)sharedController;

- (void)showContentControllerWithModel:(XPDrawerModel *)model;

@end
