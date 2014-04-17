//
//  XPPhotoView.m
//  iOS-Cook-UI
//
//  Created by XP on 4/13/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import "XPPhotoView.h"
#import "UIImageView+WebCache.h"

#define kMaximumScale 4

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
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        singleTap.delaysTouchesBegan = YES;
        singleTap.numberOfTapsRequired = YES;
        [self addGestureRecognizer:singleTap];
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        doubleTap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTap];
    }
    return self;
}

- (void)handleSingleTap:(UITapGestureRecognizer *)tap{
    
}

- (void)hide{
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)tap{
    CGPoint touchPoint = [tap locationInView:self];
	if (self.zoomScale == self.maximumZoomScale) {
		[self setZoomScale:self.minimumZoomScale animated:YES];
	} else {
		[self zoomToRect:CGRectMake(touchPoint.x, touchPoint.y, 1, 1) animated:YES];
        [self centerScrollViewContents];
	}
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
                               photoView.scrollEnabled = YES;
                           }];
}

- (void)adjustFrame{
    CGSize bounds = self.bounds.size;
    CGFloat boundsWidth = bounds.width;
    CGFloat boundsHeight = bounds.height;
    
    CGSize imageSize = self.imageView.image.size;
    CGFloat imageWidth = imageSize.width;
    CGFloat imageHeight = imageSize.height;
    
    CGSize imageViewSize = CGSizeZero;
    if (imageWidth/imageHeight <= boundsWidth/boundsHeight) {
        CGFloat height = MIN(imageHeight, boundsHeight);
        CGFloat width = height * (imageWidth/imageHeight);
        imageViewSize = CGSizeMake(width, height);
        
    }else{
        CGFloat width = MIN(imageWidth, boundsWidth);
        CGFloat height = width * (imageHeight/imageWidth);
        imageViewSize = CGSizeMake(width, height);
    }
    
    CGFloat maxScale = kMaximumScale / [[UIScreen mainScreen] scale];
    self.maximumZoomScale = maxScale;
    self.minimumZoomScale = 1;
    self.zoomScale = 1;
    
    self.contentSize = self.bounds.size;
    
    self.imageView.frame = CGRectMake(0, 0, imageViewSize.width, imageViewSize.width);
    self.imageView.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    [self centerScrollViewContents];
}

- (void)centerScrollViewContents {
    CGSize boundsSize = self.bounds.size;
    CGRect contentsFrame = self.imageView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.imageView.frame = contentsFrame;
}

@end
