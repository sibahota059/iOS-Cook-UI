//
//  XPPhotoView.m
//  iOS-Cook-UI
//
//  Created by XP on 4/13/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import "XPPhotoView.h"
#import "UIImageView+WebCache.h"

@interface XPPhotoView ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation XPPhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.clipsToBounds = YES;
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
        
        self.delegate = self;
        self.backgroundColor=[UIColor clearColor];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.scrollEnabled = NO;
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
        singleTap.delaysTouchesBegan = YES;
        singleTap.numberOfTapsRequired = YES;
        [self addGestureRecognizer:singleTap];
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
        doubleTap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTap];
    }
    return self;
}

- (void)setPhoto:(XPPhoto *)photo{
    _photo = photo;
    [self showImage];
}

- (void)showImage{
    XPPhotoView * __weak  photoView = self;
    [self.imageView setImageWithURL:self.photo.url
                   placeholderImage:self.photo.holderImage
                            options:SDWebImageRetryFailed | SDWebImageLowPriority
                           progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType){
                               [photoView adjustFrame];
                           }];
}

- (void)adjustFrame{
    CGSize bounds = self.bounds.size;
    CGFloat boundsWidth = bounds.width;
    CGFloat boundsHeight = bounds.height;
    
    CGSize imageSize = self.imageView.image.size;
    CGFloat imageWidth = imageSize.width;
    CGFloat imageHeight = imageSize.height;
    
    CGFloat minScale = boundsWidth/imageWidth;
    if (minScale > 1) {
        minScale = 1.0;
    }
    CGFloat maxScale = 2.0;
    if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
        maxScale = maxScale / [[UIScreen mainScreen] scale];
    }
    self.maximumZoomScale = maxScale;
    self.minimumZoomScale = minScale;
    self.zoomScale = minScale;
    
    CGRect imageFrame = CGRectMake(0, 0, boundsWidth, imageHeight * boundsWidth / imageWidth);
    self.contentSize = CGSizeMake(0, imageFrame.size.height);
    
    if (imageFrame.size.height < boundsHeight) {
        imageFrame.origin.y = floorf((boundsHeight - imageFrame.size.height) / 2.0);
    }else{
        imageFrame.origin.y = 0;
    }
    
    self.imageView.frame = imageFrame;
}

@end
