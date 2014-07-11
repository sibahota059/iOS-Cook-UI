//
//  XPRefreshView.h
//  iOS-Cook-UI
//
//  Created by XP on 5/31/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RADIUS 5
#define MAXOFFSET 70
#define LINEHEIGHT 20
#define VIEWHEIGHT 100
#define VIEWWIDTH 30
#define LINEHEIGHTTRANSFORMRADIO 0.3

@interface XPZoneRefreshView : UIView

@property (nonatomic, strong) UIImage *refreshCircleImage;
@property (nonatomic) BOOL isRefreshing;
@property (nonatomic) CGFloat offset;
@property (nonatomic, strong) void(^handleRefreshEvent)(void);

- (void)stopRefresh;
@end
