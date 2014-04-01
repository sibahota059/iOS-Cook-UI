//
//  XPAnimateTabViewController.h
//  iOS-Cook-UI
//
//  Created by XP on 4/1/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XPTabScrollView.h"
#import "XPContentScrollView.h"

@interface XPAnimateTabViewController : UIViewController

@property (nonatomic, strong) XPTabScrollView *tabScrollView;
@property (nonatomic, strong) XPContentScrollView *contentScrollView;

@end
