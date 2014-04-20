//
//  XPPhotoView.h
//  iOS-Cook-UI
//
//  Created by XP on 4/13/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XPPhoto.h"

@class XPPhotoView;
@protocol XPPhotoViewDelegate <NSObject>

- (void)photoViewSingleTap:(XPPhotoView *)photoView;
- (void)photoViewDidEndZoom:(XPPhotoView *)photoView;

@end

@interface XPPhotoView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, strong) XPPhoto *photo;
@property (nonatomic, weak) id<XPPhotoViewDelegate> photoViewDelegate;

@end
