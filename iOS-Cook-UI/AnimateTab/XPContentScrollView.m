//
//  XPContentScrollView.m
//  iOS-Cook-UI
//
//  Created by XP on 4/1/14.
//  Copyright (c) 2014 newland. All rights reserved.
//


#import "XPContentScrollView.h"
#import "XPTabScrollView.h"
#import "XPAnimateTabViewController.h"

#define kContentItemBaseTag 100

@interface XPContentScrollView ()

@property (nonatomic, strong) NSMutableArray *contentItems;

@end

@implementation XPContentScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.delegate = self;
        self.backgroundColor = [UIColor lightGrayColor];
        self.pagingEnabled = YES;
        self.userInteractionEnabled = YES;
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

- (void)initContentView{
    for (int i = 0; i < self.contentNameArray.count; i ++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width * i, 0, self.bounds.size.width, self.bounds.size.height)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:50];
        label.tag = kContentItemBaseTag + i;
        label.text = [self.contentNameArray objectAtIndex:i];
        [self addSubview:label];
    }
    
    self.contentSize = CGSizeMake(self.bounds.size.width * self.contentNameArray.count, self.bounds.size.height);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    XPTabScrollView *tab = self.mainViewController.tabScrollView;
    NSInteger tag = kContentItemBaseTag + (self.contentOffset.x / self.bounds.size.width);

    [tab selectTabItemFromContentView:tag];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
