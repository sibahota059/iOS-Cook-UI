//
//  XPPathCover.m
//  iOS-Cook-UI
//
//  Created by XP on 5/31/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import "XPZoneHeaderView.h"
#import "XPCategory.h"
#import "XPZoneRefreshView.h"

#define PARALLAXHEIGHT 170
#define LIGHTEFFECTPADDING 80
#define LIGHTEFFECTALPHA 1.15

@interface XPZoneHeaderView ()

@property (nonatomic, strong) XPZoneRefreshView *refrehView;

@property (nonatomic, strong) UIView *bannerView;
@property (nonatomic, strong) UIImageView *bannerImageView;
@property (nonatomic, strong) UIImageView *bannerImageViewWithImageEffects;
@property (nonatomic) CGFloat lightEffectAlpha;

@property (nonatomic) BOOL isTouching;
@property (nonatomic) CGFloat offsetY;

@end

@implementation XPZoneHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)setup{
    self.bannerView = [[UIView alloc] initWithFrame:self.bounds];
    self.bannerView.clipsToBounds = YES;
    self.bannerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -PARALLAXHEIGHT, CGRectGetWidth(self.bannerView.bounds), CGRectGetHeight(self.bannerView.bounds) + PARALLAXHEIGHT * 2)];
    self.bannerImageView.contentMode = UIViewContentModeScaleToFill;
    [self.bannerView addSubview:self.bannerImageView];
    self.bannerImageViewWithImageEffects = [[UIImageView alloc] initWithFrame:self.bannerImageView.frame];
    self.bannerImageViewWithImageEffects.alpha = 0;
    [self.bannerView addSubview:self.bannerImageViewWithImageEffects];
    [self addSubview:self.bannerView];
    
    self.refrehView = [[XPZoneRefreshView alloc] initWithFrame:CGRectMake(33, CGRectGetHeight(self.bounds) - VIEWHEIGHT, VIEWWIDTH, VIEWHEIGHT)];
    [self addSubview:self.refrehView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.isTouching = YES;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.offsetY = scrollView.contentOffset.y;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    self.isTouching = NO;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.isTouching = NO;
}

- (void)setOffsetY:(CGFloat)offsetY{
    UIView *bannerView = self.bannerView;
    CGRect bannerFrame = bannerView.frame;
    if (offsetY < 0) {
        bannerFrame.origin.y = offsetY;
        bannerFrame.size.height = -offsetY + bannerView.superview.frame.size.height;
        bannerView.frame = bannerFrame;
        CGPoint center = self.bannerImageView.center;
        center.y = bannerView.frame.size.height / 2;
        self.bannerImageView.center = center;
        
        if (offsetY > -LIGHTEFFECTPADDING) {
            float percent = -offsetY/(LIGHTEFFECTPADDING * LIGHTEFFECTALPHA);
            self.bannerImageViewWithImageEffects.alpha = percent;
        }else{
            self.bannerImageViewWithImageEffects.alpha = 1/LIGHTEFFECTALPHA;
        }
    }else{
        bannerFrame.origin.y = 0;
        bannerFrame.size.height = bannerView.superview.frame.size.height;
        bannerView.frame = bannerFrame;
    }
}

- (void)setBackgroundImage:(UIImage *)backgroundImage{
    _bannerImageView.image = backgroundImage;
    UIColor *tintColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    _bannerImageViewWithImageEffects.image = [backgroundImage applyBlurWithRadius:30 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}

- (void)setIsTouching:(BOOL)isTouching{
    _isTouching = isTouching;
}

@end
