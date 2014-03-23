//
//  XPBlurSlideBarViewController.m
//  iOS-Cook-UI
//
//  Created by XP on 3/19/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import "XPBlurSlideBarViewController.h"
#import "XPBlurSlideBarController.h"

@interface XPBlurSlideBarViewController ()

@property (nonatomic, strong) NSMutableIndexSet *optionIndices;

- (IBAction)toggleClicked:(UIButton *)sender;

@end

@implementation XPBlurSlideBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:1];
    
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toggleClicked:(UIButton *)sender {
    NSArray *images = @[
                        [UIImage imageNamed:@"gear"],
                        [UIImage imageNamed:@"globe"],
                        [UIImage imageNamed:@"profile"],
                        [UIImage imageNamed:@"star"],
                        [UIImage imageNamed:@"gear"],
                        [UIImage imageNamed:@"globe"],
                        [UIImage imageNamed:@"profile"],
                        [UIImage imageNamed:@"star"],
                        [UIImage imageNamed:@"gear"],
                        [UIImage imageNamed:@"globe"],
                        [UIImage imageNamed:@"profile"],
                        [UIImage imageNamed:@"star"],
                        ];
    NSArray *colors = @[
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
                        [UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
                        [UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
                        [UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
                        ];
    
    XPBlurSlideBarController *slideBarController = [[XPBlurSlideBarController alloc] initWithImages:images selectedIndices:self.optionIndices borderColors:colors];
    slideBarController.delegate = self;
    slideBarController.showFromRight = YES;
    [slideBarController show];

}

#pragma mark - XPBlurSlideBarController Delegate
- (void)slideBar:(XPBlurSlideBarController *)slideBar willShowOnScreenAnimated:(BOOL)animated{}
- (void)slideBar:(XPBlurSlideBarController *)slideBar didShowOnScreenAnimated:(BOOL)animated{}
- (void)slideBar:(XPBlurSlideBarController *)slideBar willDismissFromScreenAnimated:(BOOL)animated{}
- (void)slideBar:(XPBlurSlideBarController *)slideBar DidDismissFromScreenAnimated:(BOOL)animated{}
- (void)slideBar:(XPBlurSlideBarController *)slideBar didTapItemAtIndex:(NSUInteger)index{
    if (index == 3) {
        [slideBar dismiss];
    }
}

- (void)slideBar:(XPBlurSlideBarController *)slideBar didEnable:(BOOL)itemEnabled itemAtIndex:(NSUInteger)index{
    if (itemEnabled) {
        [self.optionIndices addIndex:index];
    }
    else {
        [self.optionIndices removeIndex:index];
    }
}
@end
