//
//  XPRefreshView.m
//  iOS-Cook-UI
//
//  Created by XP on 5/31/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import "XPZoneRefreshView.h"
#import "XpSoundManager.h"

@interface XPZoneRefreshView ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CAShapeLayer *lineLayer;
@property (nonatomic, strong) UIImageView *refreshView;


@end

@implementation XPZoneRefreshView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

-(void)setup{
    CGRect frame = self.frame;
    frame.size = CGSizeMake(30, 100);
    self.frame = frame;
    
    self.lineLayer = [CAShapeLayer layer];
    self.lineLayer.fillColor = [UIColor colorWithRed:222./255. green:216./255. blue:211./255. alpha:0.5].CGColor;
    [self.layer addSublayer:self.lineLayer];
    
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.fillColor = [UIColor colorWithRed:222./255. green:216./255. blue:211./255. alpha:1].CGColor;
    self.shapeLayer.strokeColor = [[UIColor whiteColor] CGColor];
    self.shapeLayer.lineWidth = 2;
    [self.layer addSublayer:self.shapeLayer];
    
    self.offset = 0;
}

- (void) setOffset:(CGFloat)offset{
    if (self.isRefreshing) {
        return;
    }else{
        CGFloat currentOffset = offset > 0 ? 0 : offset;
        currentOffset = -currentOffset;
        _offset = currentOffset;
        
        if (currentOffset < MAXOFFSET) {
            CGMutablePathRef path = [self createPathWithOffset:currentOffset];
            self.shapeLayer.path = path;
            CGPathRelease(path);
            
            CGMutablePathRef line = CGPathCreateMutable();
            float lineHeight = LINEHEIGHT + currentOffset * LINEHEIGHTTRANSFORMRADIO;
            float top = self.frame.size.height - lineHeight - RADIUS*2;
            float lineWidth = 2;
            CGPathAddRect(line, NULL, CGRectMake(VIEWWIDTH * 0.5 - lineWidth * 0.5, top + RADIUS * 2, lineWidth, lineHeight));
            self.lineLayer.path = line;
            
            self.transform = CGAffineTransformMakeScale(0.7+0.3*(LINEHEIGHT/lineHeight), 1);
        }else{
            self.offset = 0;
            [[XPSoundManager soundManager] playSound:[[NSBundle mainBundle] URLForResource:@"pullrefresh" withExtension:@"aif"]];
            if (self.handleRefreshEvent != nil) {
                self.handleRefreshEvent();
            }
            [self startRefreshAnimation];
        }
    }
}

- (CGMutablePathRef)createPathWithOffset:(float)currentOffset{
    CGMutablePathRef path = CGPathCreateMutable();
    
    float top = self.frame.size.height - LINEHEIGHT - RADIUS * 2 -currentOffset;
    if (currentOffset == 0) {
        CGPathAddEllipseInRect(path, NULL, CGRectMake(VIEWWIDTH * 0.5 - RADIUS, top, RADIUS * 2, RADIUS * 2));
    }else{
        CGPathAddArc(path, NULL, VIEWWIDTH * 0.5, top + RADIUS, RADIUS, 0, M_PI, YES);
        float bottom = top + RADIUS * 2 + currentOffset - currentOffset * LINEHEIGHTTRANSFORMRADIO;
        if (currentOffset < 10) {
            CGPathAddCurveToPoint(path, NULL, VIEWWIDTH * 0.5 - RADIUS, bottom, VIEWWIDTH * 0.5, bottom, VIEWWIDTH * 0.5, bottom);
            CGPathAddCurveToPoint(path, NULL, VIEWWIDTH * 0.5, bottom, VIEWWIDTH * 0.5 + RADIUS, bottom, VIEWWIDTH * 0.5 + RADIUS, top + RADIUS);
        }else{
            CGPathAddCurveToPoint(path, NULL, VIEWWIDTH * 0.5 - RADIUS, top + RADIUS, VIEWWIDTH * 0.5 - RADIUS, bottom - RADIUS, VIEWWIDTH * 0.5, bottom);
            CGPathAddCurveToPoint(path, NULL, VIEWWIDTH * 0.5 + RADIUS, bottom - RADIUS, VIEWWIDTH * 0.5 + RADIUS, top + RADIUS, VIEWWIDTH * 0.5 + RADIUS, top + RADIUS);
        }
    }
    CGPathCloseSubpath(path);
    return path;
}


- (void)startRefreshAnimation{
    _isRefreshing = YES;
    if (self.refreshView == nil) {
        self.refreshView = [[UIImageView alloc] initWithImage:self.refreshCircleImage];
        CGRect refreshViewFrame = self.refreshView.frame;
        refreshViewFrame.size = CGSizeMake(RADIUS*2, RADIUS*2);
        [self addSubview:self.refreshView];
    }
    self.shapeLayer.opacity = 0;
    
    _refreshView.center = CGPointMake(self.frame.size.width * 0.5,self.frame.size.height - LINEHEIGHT - RADIUS);
    [_refreshView.layer removeAllAnimations];
    _refreshView.layer.opacity = 1;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 1;
    animation.fromValue = @0;
    animation.toValue = @(M_PI * 2);
    animation.repeatCount = INT_MAX;
    
    [_refreshView.layer addAnimation:animation forKey:@"rotation"];
}

- (void)stopRefresh {
    CABasicAnimation* anim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    anim.fromValue = @(1);
    anim.toValue = @(0);
    anim.duration = 0.2;
    anim.delegate = self;
    [_refreshView.layer addAnimation:anim forKey:nil];
    _refreshView.layer.opacity = 0;
    
    
    anim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    anim.fromValue = @(0);
    anim.toValue = @(1);
    anim.beginTime = 0.2;
    anim.duration = 0.2;
    anim.delegate = self;
    [_shapeLayer addAnimation:anim forKey:nil];
    _shapeLayer.opacity = 1;
}


@end
