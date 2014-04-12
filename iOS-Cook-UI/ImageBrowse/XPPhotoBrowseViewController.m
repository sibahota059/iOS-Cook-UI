//
//  XPPhotoBrowseViewController.m
//  iOS-Cook-UI
//
//  Created by XP on 4/13/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

#import "XPPhotoBrowseViewController.h"
#import "UIImageView+WebCache.h"

#define kMargin 8
#define kPerimeter 70
#define kNumberOfColumn 4

@interface XPPhotoBrowseViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong) NSArray *photoURLArray;

@end

@implementation XPPhotoBrowseViewController

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
    self.photoURLArray = @[@"http://ww4.sinaimg.cn/thumbnail/7f8c1087gw1e9g06pc68ug20ag05y4qq.gif",
                           @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr0nly5j20pf0gygo6.jpg",
                           @"http://ww4.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr1d0vyj20pf0gytcj.jpg",
                           @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr1xydcj20gy0o9q6s.jpg",
                           @"http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr2n1jjj20gy0o9tcc.jpg",
                           @"http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr39ht9j20gy0o6q74.jpg",
                           @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr3xvtlj20gy0obadv.jpg",
                           @"http://ww4.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr4nndfj20gy0o9q6i.jpg",
                           @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr57tn9j20gy0obn0f.jpg"];

    NSInteger numberOfPhotos = self.photoURLArray.count;
    NSInteger numberOfRows = (numberOfPhotos + 1)/kNumberOfColumn + 1;
    self.scrollView.contentSize = CGSizeMake((kMargin + kPerimeter) * kNumberOfColumn + kMargin, (kMargin + kPerimeter) * numberOfRows + kMargin);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    UIImage *holderImage = [UIImage imageNamed:@"holderImage"];
    for (int i = 0; i < numberOfPhotos; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        int columnIndex = i%kNumberOfColumn;
        int rowIndex = i/kNumberOfColumn;
        CGRect frame = CGRectMake(kMargin + (kPerimeter + kMargin) * columnIndex, kMargin + (kPerimeter + kMargin) * rowIndex, kPerimeter, kPerimeter);
        imageView.frame = frame;
        [self.scrollView addSubview:imageView];
        
        [imageView setImageWithURL:[self.photoURLArray objectAtIndex:i] placeholderImage:holderImage options:SDWebImageRetryFailed | SDWebImageLowPriority];
        imageView.tag = i;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)]];
        imageView.userInteractionEnabled = YES;
        imageView.clipsToBounds = YES;
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imageTapped:(UITapGestureRecognizer *)tap{

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
