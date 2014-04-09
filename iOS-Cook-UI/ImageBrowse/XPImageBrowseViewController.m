//
//  XPImageBrowseViewController.m
//  iOS-Cook-UI
//
//  Created by XP on 4/3/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

static NSString *CellIdentifier = @"Cell";

#import "XPImageBrowseViewController.h"

@interface XPImageBrowseViewController ()
@property (strong, nonatomic) UISegmentedControl *segmentControl;
@property (nonatomic, strong) NSMutableArray *assets;

@end

@implementation XPImageBrowseViewController

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
    self.segmentControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Push", @"Modal", nil]];
    [self.segmentControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.segmentControl];
    self.navigationItem.rightBarButtonItem = item;
    self.segmentControl.selectedSegmentIndex = 0;
    [self loadAssets];
}

- (void)loadAssets{
    self.assets = [NSMutableArray array];
    ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *assetGroups = [NSMutableArray array];
        NSMutableArray *assetURLDictionaries = [NSMutableArray array];
                                       
        void(^assetEnumerator)(ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop){
            if (result != nil) {
                if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                    [assetURLDictionaries addObject:[result valueForProperty:ALAssetPropertyURLs]];
                    NSURL *url = result.defaultRepresentation.url;
                    [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset){
                        if (asset) {
                            @synchronized(self){
                                [self.assets addObject:asset];
                                if (self.assets.count == 1) {
                                    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
                                }
                            }
                        }
                    }
                                 failureBlock:nil];
                }
            }
        };
        
        void(^assetGroupEnmerator)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop){
            if (group != nil) {
                [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:assetEnumerator];
                [assetGroups addObject:group];
            }
        };
        
        [assetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:assetGroupEnmerator failureBlock:nil];
    });
}

- (IBAction)segmentChanged:(id)sender {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = 3;
    @synchronized(self){
        if (self.assets.count) {
            rows ++;
        }
    }
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = self.segmentControl.selectedSegmentIndex == 0 ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Multiple photo grid";
            cell.detailTextLabel.text = @"showing grid first";
            break;
        case 1:
            cell.textLabel.text = @"Photo selection grid";
            cell.detailTextLabel.text = @"selection enabled, start at grid";
            break;
        case 2:
            cell.textLabel.text = @"Web photo grid";
            cell.detailTextLabel.text = @"show grid first";
            break;
        case 3:
            cell.textLabel.text = @"Library photos";
            cell.detailTextLabel.text = @"photos from device library";
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *photos = [NSMutableArray array];
    switch (indexPath.row) {
        case 0:
        {
            XPPhoto *photo;
            photo = [XPPhoto photoWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"photo2" ofType:@"jpg"]]];
            photo.caption = @"White Tower";
			[photos addObject:photo];
            photo = [XPPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"photo3" ofType:@"jpg"]]];
            photo.caption = @"The London Eye is a giant Ferris wheel situated on the banks of the River Thames, in London, England.";
			[photos addObject:photo];
            photo = [XPPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"photo4" ofType:@"jpg"]]];
            photo.caption = @"York Floods";
			[photos addObject:photo];
            photo = [XPPhoto photoWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"photo5" ofType:@"jpg"]]];
            photo.caption = @"Campervan";
			[photos addObject:photo];
            break;
        }
        default:
            break;
    }
    
    XPPhotoBrowser *browser = [[XPPhotoBrowser alloc] init];
    browser.photos = photos;
    if (self.segmentControl.selectedSegmentIndex == 0) {
        [self.navigationController pushViewController:browser animated:YES];
    }else{
        UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:browser];
        nv.modalPresentationStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:nv animated:YES completion:nil];
    }
}
@end
