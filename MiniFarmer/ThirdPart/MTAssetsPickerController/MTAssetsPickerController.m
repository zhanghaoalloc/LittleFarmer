//
//  MTAssetsPickController.m
//  MengCampus
//
//  Created by renqingyang on 15/3/5.
//  Copyright (c) 2015年 QiCool. All rights reserved.
//

#import "MTAssetsPickerController.h"
#import "MTPickerInfo.h"
#import "UIButton+MTButtonCheckMarkAnimation.h"

//#import "UIColor+MTColor.h"

#import "Masonry.h"

static NSArray *selection;

static NSInteger numberOfSelection;

#define MTThumbnailLength    89.0f
static CGFloat CELL_ROW = 4;
static CGFloat CELL_MARGIN = 2;
static CGFloat CELL_LINE_MARGIN = 2;

#pragma mark - Interfaces

@protocol MTAssetsViewCellSelectedDelegate <NSObject>

- (void) pickerCollectionViewCellDidChangedWithSelected:(BOOL)selected andALAsset:(ALAsset *)asset;

@end

@interface MTAssetsPickerController ()

@end

@interface MTAssetsGroupViewController : UITableViewController
@end


@interface MTAssetsGroupViewController()

@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) NSMutableArray *groups;

@end


@interface MTAssetsViewController : UICollectionViewController<MTAssetsViewCellSelectedDelegate>

@property (nonatomic, strong) ALAssetsGroup *assetsGroup;

@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) NSMutableArray *selectionArray;
@end

@interface MTAssetsViewController ()

@property (nonatomic, strong) NSMutableArray *assets;
@property (nonatomic, assign) NSInteger numberOfPhotos;

@end


@interface MTAssetsGroupViewCell : UITableViewCell

- (void)bind:(ALAssetsGroup *)assetsGroup;

@end

@interface MTAssetsGroupViewCell ()

@property (nonatomic, strong) ALAssetsGroup *assetsGroup;

@end

@interface MTAssetsViewCell : UICollectionViewCell

@property (nonatomic, strong)UIButton *checkMarkButton;

- (void)bind:(ALAsset *)asset;

@property (nonatomic , weak) id <MTAssetsViewCellSelectedDelegate> collectionViewCellDelegate;
@end

@interface MTAssetsViewCell ()

@property (nonatomic, strong) ALAsset *asset;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *title;

@end


#pragma mark - MTAssetsPickerController


@implementation MTAssetsPickerController
@synthesize delegate;
+ (void) selections:(NSArray *)array withMaximNum:(NSInteger)num{
    @synchronized ([NSArray class]) {
        
        selection = array;
        numberOfSelection = 0;
        maximumNumberOfSelection = num;
    }
}
- (id)init
{
    MTAssetsGroupViewController *groupViewController = [[MTAssetsGroupViewController alloc] init];
    
    if (self = [super initWithRootViewController:groupViewController])
    {
        _assetsFilter               = [ALAssetsFilter allAssets];
        _showsCancelButton          = YES;
        [self makeNavigationBar:self.navigationBar];
    }
    
    return self;
}
- (void)makeNavigationBar:(UINavigationBar *)navBar
{
    NSDictionary *textAttributes = nil;
    if ([[[UIDevice currentDevice] systemVersion] integerValue] >= 7.0) {
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:20],
                           NSForegroundColorAttributeName: [UIColor whiteColor],
                           };
        [navBar setTintColor:[UIColor whiteColor]];
        [navBar setBarTintColor:[UIColor colorWithRed:0.0/255 green:117.0/255.0 blue:196.0/255.0 alpha:0.7]];
    } else {
        navBar.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:117.0f/255.0f blue:196.0f/255.0f alpha:0.7f];
        
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:20],
                           UITextAttributeTextColor: [UIColor whiteColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    [navBar setTitleTextAttributes:textAttributes];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

#pragma mark - CTAssetsGroupViewController

@implementation MTAssetsGroupViewController


- (id)init
{
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViews];
    [self setupButtons];
    [self localize];
    [self setupGroup];
}


#pragma mark - Setup

- (void)setupViews
{
    self.tableView.rowHeight = MTThumbnailLength + 12;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setupButtons
{
    MTAssetsPickerController *picker = (MTAssetsPickerController *)self.navigationController;
    
    if (picker.showsCancelButton)
    {
        self.navigationItem.rightBarButtonItem =
        [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(dismiss:)];
    }
}

- (void)localize
{
    self.title = @"照片";
}

- (void)setupGroup
{
    if (!self.assetsLibrary)
        self.assetsLibrary = [self.class defaultAssetsLibrary];
    
    if (!self.groups)
        self.groups = [[NSMutableArray alloc] init];
    else
        [self.groups removeAllObjects];
    
    MTAssetsPickerController *picker = (MTAssetsPickerController *)self.navigationController;
    ALAssetsFilter *assetsFilter = picker.assetsFilter;
    
    ALAssetsLibraryGroupsEnumerationResultsBlock resultsBlock = ^(ALAssetsGroup *group, BOOL *stop) {
        
        if (group)
        {
            [group setAssetsFilter:assetsFilter];
            
            if (group.numberOfAssets > 0)
                [self.groups addObject:group];
            
        }
        else
        {
            [self reloadData];
        }
    };
    
    
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
        
        [self showNotAllowed];
        
    };
    
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                                      usingBlock:resultsBlock
                                    failureBlock:failureBlock];
    
    NSUInteger type =
    ALAssetsGroupLibrary | ALAssetsGroupAlbum | ALAssetsGroupEvent |
    ALAssetsGroupFaces | ALAssetsGroupPhotoStream;
    
    [self.assetsLibrary enumerateGroupsWithTypes:type
                                      usingBlock:resultsBlock
                                    failureBlock:failureBlock];
}


#pragma mark - Reload Data

- (void)reloadData
{
    if (self.groups.count == 0)
        [self showNoAssets];
    
    [self.tableView reloadData];
}


#pragma mark - ALAssetsLibrary

+ (ALAssetsLibrary *)defaultAssetsLibrary
{
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    return library;
}


#pragma mark - Not allowed / No assets

- (void)showNotAllowed
{
    self.title              = nil;
    
    UIView *lockedView      = [[UIView alloc] initWithFrame:self.view.bounds];
    UIImageView *locked     = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    
    
    CGRect rect             = CGRectInset(self.view.bounds, 8, 8);
    UILabel *title          = [[UILabel alloc] initWithFrame:rect];
    UILabel *message        = [[UILabel alloc] initWithFrame:rect];
    
    title.text              = @"此 App 无法取用您的照片或影片。";
    title.font              = [UIFont boldSystemFontOfSize:17.0];
    title.textColor         = [UIColor colorWithRed:129.0/255.0 green:136.0/255.0 blue:148.0/255.0 alpha:1];
    title.textAlignment     = NSTextAlignmentCenter;
    title.numberOfLines     = 5;
    
    message.text            = @"您可以在「隐私设定」中启用存取。";
    message.font            = [UIFont systemFontOfSize:14.0];
    message.textColor       = [UIColor colorWithRed:129.0/255.0 green:136.0/255.0 blue:148.0/255.0 alpha:1];
    message.textAlignment   = NSTextAlignmentCenter;
    message.numberOfLines   = 5;
    
    [title sizeToFit];
    [message sizeToFit];
    
    locked.center           = CGPointMake(lockedView.center.x, lockedView.center.y - 40);
    title.center            = locked.center;
    message.center          = locked.center;
    
    rect                    = title.frame;
    rect.origin.y           = locked.frame.origin.y + locked.frame.size.height + 20;
    title.frame             = rect;
    
    rect                    = message.frame;
    rect.origin.y           = title.frame.origin.y + title.frame.size.height + 10;
    message.frame           = rect;
    
    [lockedView addSubview:locked];
    [lockedView addSubview:title];
    [lockedView addSubview:message];
    
    self.tableView.tableHeaderView  = lockedView;
    self.tableView.scrollEnabled    = NO;
}

- (void)showNoAssets
{
    UIView *noAssetsView    = [[UIView alloc] initWithFrame:self.view.bounds];
    
    CGRect rect             = CGRectInset(self.view.bounds, 10, 10);
    UILabel *title          = [[UILabel alloc] initWithFrame:rect];
    UILabel *message        = [[UILabel alloc] initWithFrame:rect];
    
    title.text              = @"沒有照片或影片";
    title.font              = [UIFont systemFontOfSize:26.0];
    title.textColor         = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
    title.textAlignment     = NSTextAlignmentCenter;
    title.numberOfLines     = 5;
    
    message.text            = @"您可以使用 iTunes 將照片和影片\n同步到 iPhone。";
    message.font            = [UIFont systemFontOfSize:18.0];
    message.textColor       = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
    message.textAlignment   = NSTextAlignmentCenter;
    message.numberOfLines   = 5;
    
    [title sizeToFit];
    [message sizeToFit];
    
    title.center            = CGPointMake(noAssetsView.center.x, noAssetsView.center.y - 10 - title.frame.size.height / 2);
    message.center          = CGPointMake(noAssetsView.center.x, noAssetsView.center.y + 10 + message.frame.size.height / 2);
    
    [noAssetsView addSubview:title];
    [noAssetsView addSubview:message];
    
    self.tableView.tableHeaderView  = noAssetsView;
    self.tableView.scrollEnabled    = NO;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.groups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    MTAssetsGroupViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[MTAssetsGroupViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    [cell bind:[self.groups objectAtIndex:indexPath.row]];
    
    return cell;
}


#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MTThumbnailLength + 12;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTAssetsViewController *vc = [[MTAssetsViewController alloc] init];
    vc.assetsGroup = [self.groups objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Actions

- (void)dismiss:(id)sender
{
    MTAssetsPickerController *picker = (MTAssetsPickerController *)self.navigationController;
    
    if ([picker.delegate respondsToSelector:@selector(mt_AssetsPickerControllerDidCancel:)])
        [picker.delegate mt_AssetsPickerControllerDidCancel:picker];
    
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

@end



#pragma mark - CTAssetsGroupViewCell

@implementation MTAssetsGroupViewCell


- (void)bind:(ALAssetsGroup *)assetsGroup
{
    self.assetsGroup            = assetsGroup;
    
    CGImageRef posterImage      = assetsGroup.posterImage;
    size_t height               = CGImageGetHeight(posterImage);
    float scale                 = height / MTThumbnailLength;
    
    self.imageView.image        = [UIImage imageWithCGImage:posterImage scale:scale orientation:UIImageOrientationUp];
    self.textLabel.text         = [assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    self.detailTextLabel.text   = [NSString stringWithFormat:@"%ld", (long)[assetsGroup numberOfAssets]];
    self.accessoryType          = UITableViewCellAccessoryDisclosureIndicator;
}

@end




#pragma mark - MTAssetsViewController

#define MTAssetsViewCellIdentifier           @"AssetsViewCellIdentifier"

@implementation MTAssetsViewController

- (id)init
{
    UICollectionViewFlowLayout *layout  = [[UICollectionViewFlowLayout alloc] init];
    CGFloat cellW = ([[UIScreen mainScreen] bounds].size.width - CELL_MARGIN * (CELL_ROW + 1)) / CELL_ROW;
    layout.itemSize = CGSizeMake(cellW, cellW);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = CELL_LINE_MARGIN;
    
    if (self = [super initWithCollectionViewLayout:layout])
    {
        self.collectionView.allowsMultipleSelection = YES;
        
        [self.collectionView registerClass:[MTAssetsViewCell class]
                forCellWithReuseIdentifier:MTAssetsViewCellIdentifier];
        
        if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
            [self setEdgesForExtendedLayout:UIRectEdgeNone];
        self.collectionView.contentInset=UIEdgeInsetsMake(2.0, 2.0, 0.0, 2.0);
        self.selectionArray = [NSMutableArray new];
        
    }
    CGRect rect = self.collectionView.frame;
    self.collectionView.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height-54.0f);
    self.view.backgroundColor = [UIColor whiteColor];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViews];
    [self setupButtons];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupAssets];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    numberOfSelection = 0;
    
}
#pragma mark - Setup
#pragma mark makeView countView

- (void)setupViews
{
    CGRect rect = self.collectionView.frame;

    self.collectionView.backgroundColor = [UIColor whiteColor];
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(rect.origin.x, rect.size.height - 54.0-44.0f, rect.size.width, 54.0f)];
    bottomView.backgroundColor = [UIColor colorWithRed:246.0f/255.0f green:246.0f/255.0f blue:246.0f/255.0f alpha:0.9];
    [self.view addSubview:bottomView];
    
    self.sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sureButton setTitleColor:[UIColor colorWithHexString:@"0x0075C4"] forState:UIControlStateNormal];
    self.sureButton.enabled = YES;
    self.sureButton.titleLabel.font = [UIFont systemFontOfSize:18];
    self.sureButton.frame = CGRectMake(self.view.bounds.size.width - 51, self.view.bounds.size.height - 18.5 - 44.0f-17.75f - 10, 36, 18.5);
    [self.sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.sureButton addTarget:self action:@selector(finishPickingAssets:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sureButton];
    
    self.countLabel = [[UILabel alloc] init];
    self.countLabel.textColor = [UIColor whiteColor];
    self.countLabel.textAlignment = NSTextAlignmentCenter;
    self.countLabel.font = [UIFont systemFontOfSize:14];
    self.countLabel.frame = CGRectMake(self.view.bounds.size.width - 51 - 20 -5, self.view.bounds.size.height - 20 - 44.0f-17.f - 10, 20, 20);
    self.countLabel.hidden = YES;
    self.countLabel.layer.cornerRadius = self.countLabel.frame.size.height / 2.0;
    self.countLabel.clipsToBounds = YES;
    self.countLabel.backgroundColor = [UIColor colorWithHexString:@"0x0075C4"];
    [self.view addSubview:self.countLabel];
    
}

- (void)setupButtons
{
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(cancelPickingAssets:)];
}

- (void)setupAssets
{
    self.title = [self.assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    
    if (!self.assets)
        self.assets = [[NSMutableArray alloc] init];
    else
        [self.assets removeAllObjects];
    
    ALAssetsGroupEnumerationResultsBlock resultsBlock = ^(ALAsset *asset, NSUInteger index, BOOL *stop) {
        
        if (asset)
        {
            [self.assets addObject:asset];
        }
        
        if (self.assets.count > 0)
        {
            [self.collectionView reloadData];
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.assets.count-1 inSection:0]
                                        atScrollPosition:UICollectionViewScrollPositionTop
                                                animated:YES];
        }
    };
    
    [self.assetsGroup enumerateAssetsUsingBlock:resultsBlock];
}


#pragma mark - Collection View Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = MTAssetsViewCellIdentifier;
    
    MTAssetsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.collectionViewCellDelegate = self;
    [cell bind:[self.assets objectAtIndex:indexPath.row]];
    
    return cell;
}


#pragma mark - Collection View Delegate

//- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (maximumNumberOfSelection > numberOfSelection ) {
//        numberOfSelection ++;
//        return YES;
//    }
//    else
//        return NO;
//}
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//   numberOfSelection --;
//   return YES;
//}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - Actions

- (void)finishPickingAssets:(id)sender
{
    
    MTAssetsPickerController *picker = (MTAssetsPickerController *)self.navigationController;
    
    if ([picker.delegate respondsToSelector:@selector(mt_AssetsPickerController:didFinishPickingAssets:)])
        [picker.delegate mt_AssetsPickerController:picker didFinishPickingAssets:self.selectionArray];
    
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}
- (void)cancelPickingAssets:(id)sender
{
    MTAssetsPickerController *picker = (MTAssetsPickerController *)self.navigationController;
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}
#pragma mark - MTAssetsViewCellSelectedDelegate
-(void)pickerCollectionViewCellDidChangedWithSelected:(BOOL)selected andALAsset:(ALAsset *)asset
{
    [self.countLabel.layer removeAllAnimations];
    CAKeyframeAnimation *scaoleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaoleAnimation.duration = 0.25;
    scaoleAnimation.autoreverses = YES;
    scaoleAnimation.values = @[[NSNumber numberWithFloat:1.0],[NSNumber numberWithFloat:1.2],[NSNumber numberWithFloat:1.0]];
    scaoleAnimation.fillMode = kCAFillModeForwards;
    [self.countLabel.layer addAnimation:scaoleAnimation forKey:@"transform.rotate"];
    
    self.countLabel.hidden = !numberOfSelection;
    self.countLabel.text = [NSString stringWithFormat:@"%ld",(long)numberOfSelection];
    self.sureButton.enabled = (numberOfSelection > 0);
    if (selected) {
        [self.selectionArray addObject:asset];
    }
    else
        [self.selectionArray removeObject:asset];
}
@end
#pragma mark - MTAssetsViewCell

@implementation MTAssetsViewCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.opaque                     = YES;
        self.isAccessibilityElement     = YES;
        self.accessibilityTraits        = UIAccessibilityTraitImage;
        
        self.checkMarkButton = [[UIButton alloc] initWithFrame:self.bounds];
        [self.checkMarkButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, frame.size.width - 24.0f,frame.size.height - 24.0f, 0)];
        [self addSubview:self.checkMarkButton];
        
        [self.checkMarkButton addTarget:self action:@selector(tapCheckMark) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}
- (CGRect)checkmarkFrameUsingItemFrame:(CGRect)frame
{
    CGRect checkmarkRect = CGRectMake(0.0f, 0.0f, 24.0f, 24.0f);
    
    return CGRectMake(
                      frame.size.width - checkmarkRect.size.width - checkmarkRect.origin.x,
                      0,
                      checkmarkRect.size.width,
                      checkmarkRect.size.height
                      );
}

- (void)tapCheckMark
{
    if (self.selected) {
        numberOfSelection --;
        [self.checkMarkButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        self.selected = NO;
        // 告诉代理现在被点击了!
        if ([self.collectionViewCellDelegate respondsToSelector:@selector(pickerCollectionViewCellDidChangedWithSelected:andALAsset:)]) {
            [self.collectionViewCellDelegate pickerCollectionViewCellDidChangedWithSelected:self.selected andALAsset:self.asset];
        }
    }
    else{
        if (maximumNumberOfSelection > numberOfSelection ) {
            numberOfSelection ++;
            self.selected = YES;
            // 告诉代理现在被点击了!
            if ([self.collectionViewCellDelegate respondsToSelector:@selector(pickerCollectionViewCellDidChangedWithSelected:andALAsset:)]) {
                [self.collectionViewCellDelegate pickerCollectionViewCellDidChangedWithSelected:self.selected andALAsset:self.asset];
            }
        }
        else{
            NSString *format = [NSString stringWithFormat:@"最多只能选择%zd张图片",maximumNumberOfSelection];
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:format delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
            [alertView show];
            return ;
        }
    }
    
}
- (void)bind:(ALAsset *)asset
{
    BOOL new = YES;
    if (self.asset) {
        new = NO;
    }
    self.asset  = asset;
    self.image  = [UIImage imageWithCGImage:asset.thumbnail];
    self.type   = [asset valueForProperty:ALAssetPropertyType];
    //性能需要优化
    
    [selection enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[MTPickerInfo class]]) {
            MTPickerInfo *temp = (MTPickerInfo *)obj;
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData *data1 = UIImagePNGRepresentation(temp.image);
                NSData *data = UIImagePNGRepresentation(self.image);
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([data isEqual:data1]) {
                        if (new) {
                            numberOfSelection ++;
                        }
                        self.selected = YES;
                        if ([self.collectionViewCellDelegate respondsToSelector:@selector(pickerCollectionViewCellDidChangedWithSelected:andALAsset:)]) {
                            [self.collectionViewCellDelegate pickerCollectionViewCellDidChangedWithSelected:self.selected andALAsset:self.asset];
                        }
                        return ;
                    }
                    
                });
            });
        }
    }];
    [self setNeedsDisplay];
}
- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (self.selected) {
        [self.checkMarkButton mt_setImageWithAnimation:[UIImage imageNamed:@"ask_picture_checkmark"] forState:UIControlStateNormal];
        
    } else {
        [self.checkMarkButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    
}
// Draw everything to improve scrolling responsiveness

- (void)drawRect:(CGRect)rect
{
    // Image
    CGFloat cellW = ([[UIScreen mainScreen] bounds].size.width - CELL_MARGIN * CELL_ROW + 1) / CELL_ROW;
    [self.image drawInRect:CGRectMake(0, 0, cellW, cellW)];
}


@end

