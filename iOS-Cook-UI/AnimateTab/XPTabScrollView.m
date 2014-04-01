//
//  XPTabScrollView.m
//  iOS-Cook-UI
//
//  Created by XP on 4/1/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import "XPTabScrollView.h"
#import "XPCategory.h"
#import "XPAnimateTabViewController.h"

#define kTabItemBaseTag 100
#define kTabItemMargin 5

@interface XPTabScrollView ()

@property (nonatomic, strong) NSMutableArray *tabItems;
@property (nonatomic, strong) UIImageView *animateImageView;

@end

@implementation XPTabScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.delegate = self;
        self.backgroundColor = [UIColor clearColor];
        self.pagingEnabled = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

- (void)initTabView{
    self.tabItems = [NSMutableArray array];
    float xPosition = 0;
    for (int i = 0; i < self.tabNameArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *title = [self.tabNameArray objectAtIndex:i];
        button.tag = kTabItemBaseTag + i;
        if (i == 0) {
            button.selected = YES;
            self.selectedTabItem = button.tag;
        }
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:18];
        [button setTitleColor:[UIColor colorFromHexString:@"868686"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorFromHexString:@"bb0b15"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(tabSelected:) forControlEvents:UIControlEventTouchUpInside];
        float buttonWidth = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}].width + kTabItemMargin * 2;
        button.frame = CGRectMake(xPosition, 0, buttonWidth, 44);
        xPosition = xPosition + buttonWidth;
        [self.tabItems addObject:button];
        [self addSubview:button];
    }
    
    self.contentSize = CGSizeMake(xPosition, 44);
    UIButton *firstButton = [self.tabItems objectAtIndex:0];
    self.animateImageView = [[UIImageView alloc] initWithFrame:firstButton.frame];
    self.animateImageView.image = [UIImage imageNamed:@"animateImage"];
    [self addSubview:self.animateImageView];
}

- (void)tabSelected:(UIButton *)sender{
    [self scrollToItem:sender];
    
    if (self.selectedTabItem != sender.tag) {
        UIButton *lastButton = (UIButton *)[self viewWithTag:self.selectedTabItem];
        [lastButton setSelected:NO];
        self.selectedTabItem = sender.tag;
    }
    
    if (!sender.selected) {
        sender.selected = YES;
        [UIView animateWithDuration:0.5
                         animations:^{
                             [self.animateImageView setFrame:sender.frame];
                         }
                         completion:^(BOOL finished){
                             if (finished) {
                                 [self.mainViewController.contentScrollView setContentOffset:CGPointMake((sender.tag - kTabItemBaseTag) * self.frame.size.width, 0) animated:YES];
                                 self.mainViewController.contentScrollView.selectedTabItem = sender.tag;
                             }
                         }];
    }
}

- (void)selectTabItemFromContentView:(NSInteger)tag{
    UIButton *btn = (UIButton *)[self viewWithTag:tag];
    
    
    [self scrollToItem:btn];
    
    if (self.selectedTabItem != btn.tag) {
        UIButton *lastButton = (UIButton *)[self viewWithTag:self.selectedTabItem];
        [lastButton setSelected:NO];
        self.selectedTabItem = btn.tag;
    }
    
    if (!btn.selected) {
        btn.selected = YES;
        [UIView animateWithDuration:0.5
                         animations:^{
                             [self.animateImageView setFrame:btn.frame];
                         }
                         completion:nil];
    }
}

- (void)scrollToItem:(UIView *)item{
    float selectedItemX = item.frame.origin.x;
    float selectedItemWith = item.bounds.size.width;
    
    if (selectedItemX - self.contentOffset.x > self.bounds.size.width - selectedItemWith) {
        [self setContentOffset:CGPointMake(selectedItemX + item.bounds.size.width - self.bounds.size.width, 0) animated:YES];
    }
    if (selectedItemX < self.contentOffset.x) {
        [self setContentOffset:CGPointMake(selectedItemX, 0) animated:YES];
    }
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
