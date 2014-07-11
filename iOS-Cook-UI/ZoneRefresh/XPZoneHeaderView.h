//
//  XPPathCover.h
//  iOS-Cook-UI
//
//  Created by XP on 5/31/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XPZoneHeaderView : UIView

@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) void(^handleRefreshEvent)(void);

- (void)stopRefresh;
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;

@end
