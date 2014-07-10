//
//  XPRefreshView.m
//  iOS-Cook-UI
//
//  Created by XP on 5/31/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import "XPZoneRefreshView.h"

@interface XPZoneRefreshView ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CAShapeLayer *lineLayer;
@property (nonatomic) CGFloat offset;

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
            float wdiff = currentOffset * 0.2;
            float top = self.frame.size.height - 20 - RADIUS*2 - currentOffset;
            
            CGMutablePathRef path = [self createPathWithOffset:currentOffset];
            self.shapeLayer.path = path;
            CGPathRelease(path);
            
            CGMutablePathRef line = CGPathCreateMutable();
            float lineWidth = ((MAXOFFSET - currentOffset)/MAXOFFSET) + 1;
            CGPathAddRect(line, NULL, CGRectMake(VIEWWIDTH * 0.5 - lineWidth * 0.5, top + wdiff + RADIUS * 2, lineWidth, currentOffset - wdiff + OFFSETHEIGHT));
            self.lineLayer.path = line;
            
            self.transform = CGAffineTransformMakeScale(0.8 + 0.2 * (lineWidth - 1), 1);
        }else{

        }
    }
}

- (CGMutablePathRef)createPathWithOffset:(float)currentOffset{
    CGMutablePathRef path = CGPathCreateMutable();
    float top = self.frame.size.height - 20 - RADIUS * 2 -currentOffset;
    float wdiff = currentOffset * DEFORMATIONLENGTH;
    if (currentOffset == 0) {
        CGPathAddEllipseInRect(path, NULL, CGRectMake(VIEWWIDTH * 0.5 - RADIUS, top, RADIUS * 2, RADIUS * 2));
    }else{
        CGPathAddArc(path, NULL, VIEWWIDTH * 0.5, top + RADIUS, RADIUS, 0, M_PI, YES);
        float bottom = top + wdiff + RADIUS * 2;
        if (currentOffset < 10) {
            CGPathAddCurveToPoint(path, NULL, VIEWWIDTH * 0.5 - RADIUS, bottom, VIEWWIDTH * 0.5, bottom, VIEWWIDTH * 0.5, bottom);
            CGPathAddCurveToPoint(path, NULL, VIEWWIDTH * 0.5, bottom, VIEWWIDTH * 0.5 + RADIUS, bottom, VIEWWIDTH * 0.5 + RADIUS, top + RADIUS);
        }else{
            CGPathAddCurveToPoint(path, NULL, VIEWWIDTH * 0.5, top + RADIUS, VIEWWIDTH * 0.5 - RADIUS, bottom - RADIUS, VIEWWIDTH * 0.5, bottom);
            CGPathAddCurveToPoint(path, NULL, VIEWWIDTH * 0.5 + RADIUS, bottom - RADIUS, VIEWWIDTH * 0.5 + RADIUS, top + RADIUS, VIEWWIDTH * 0.5 + RADIUS, top + RADIUS);
        }
    }
    CGPathCloseSubpath(path);
    return path;
}















@end
