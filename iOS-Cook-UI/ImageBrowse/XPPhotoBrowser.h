//
//  XPPhotoBrowser.h
//  iOS-Cook-UI
//
//  Created by XP on 4/13/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XPPhotoToolbar.h"
#import "XPPhoto.h"
#import "XPPhotoView.h"
#import "SDWebImageManager.h"

@interface XPPhotoBrowser : UIViewController <UIScrollViewDelegate>

@property (nonatomic) NSInteger currentIndex;
@property (nonatomic, strong) NSArray *photos;

- (void)show;

@end
