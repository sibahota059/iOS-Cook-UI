//
//  XPMenuView.h
//  iOS-Cook-UI
//
//  Created by XP on 5/15/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XPMenu.h"

@interface XPMenuView : UIImageView

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *moreChannelsLabel;
@property (nonatomic, strong) XPMenu *menu;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) NSMutableArray *viewArray1;
@property (nonatomic, strong) NSMutableArray *viewArray2;

@end
