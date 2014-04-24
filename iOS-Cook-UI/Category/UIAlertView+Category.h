//
//  UIAlertView+Category.h
//  iOS-Cook-UI
//
//  Created by XP on 4/23/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (Category)

-(void)showWithCompletion:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))completion;

@end
