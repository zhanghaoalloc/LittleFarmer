//
//  MyResponseViewController.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/18.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MyResponseViewController.h"
#import "MineAskQuestionViewController.h"
#import "MineReponseTableViewController.h"
#import "YHSegmentView.h"
#import "UIView+FrameCategory.h"

@interface MyResponseViewController ()<UIScrollViewDelegate,YHSegmentViewDelegate>

@property (nonatomic, strong) UIScrollView *mineScrollview;
@property (nonatomic, strong) YHSegmentView *segmentView;

@end

@implementation MyResponseViewController

- (instancetype)init
{
    if (self = [super init])
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"eeeeee"]];
    [self setBarTitle:@"我的回答"];
    [self addSubviews];
    [self setupSegmentItem];
    [[self currentVC] reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - other
- (void)addSubviews
{
    //添加scrollvieww
    [self.view addSubview:self.mineScrollview];
    [self.view addSubview:self.segmentView];
    
    
    self.segmentView.frame = CGRectMake(0, self.yDispaceToTop, kScreenSizeWidth, 47);

    MineAskQuestionViewController *myQVC = [[MineAskQuestionViewController alloc] init];
    [self.mineScrollview addSubview:myQVC.view];
    [myQVC.view setBackgroundColor:[UIColor redColor]];
    [self addChildViewController:myQVC];
    
    MineReponseTableViewController *mineVC = [[MineReponseTableViewController alloc] init];
    [self.mineScrollview addSubview:mineVC.view];
    [myQVC.view setBackgroundColor:[UIColor orangeColor]];
    [self addChildViewController:mineVC];
    
   
    
    
    
    self.mineScrollview.frame = CGRectMake(0, CGRectGetMaxY(self.segmentView.frame), kScreenSizeWidth, kScreenSizeHeight - self.yDispaceToTop);
    myQVC.view.frame = CGRectMake(0,0, kScreenSizeWidth, CGRectGetHeight(self.mineScrollview.frame));

    mineVC.view.frame = CGRectMake(kScreenSizeWidth, 0, kScreenSizeWidth, CGRectGetHeight(self.mineScrollview.frame));
    
    [self.mineScrollview setContentSize:CGSizeMake(kScreenSizeWidth * 2, CGRectGetHeight(self.mineScrollview.frame))];
    
}

- (UIScrollView *)mineScrollview
{
    if (!_mineScrollview) {
        _mineScrollview = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _mineScrollview.showsHorizontalScrollIndicator = NO;
        _mineScrollview.showsVerticalScrollIndicator = NO;
        _mineScrollview.delegate = self;
        _mineScrollview.pagingEnabled = YES;
        
        
    }
    return _mineScrollview;
}

- (YHSegmentView *)segmentView
{
    if (!_segmentView)
    {
        _segmentView = [[YHSegmentView alloc] init];
        _segmentView.backgroundColor = [UIColor whiteColor];
        _segmentView.itemToLeft = 64;
        _segmentView.directionLineHeigth = 4;
        _segmentView.itemsDispace = 64;
        _segmentView.textSelectedColor = [UIColor colorWithHexString:@"#ff6633"];
        _segmentView.textNormalColor = [UIColor colorWithHexString:@"#666666"];
        _segmentView.directionLineColor = [UIColor colorWithHexString:@"#ff6633"];
        _segmentView.bottomLineHeigth = 1;
        _segmentView.bottomLineColor = [UIColor colorWithHexString:@"#e4e4e4"];
        _segmentView.delegate = self;
    }
    return _segmentView;
}


- (void)setupSegmentItem
{
    NSArray *titles = @[@"我的提问",@"我的问答"];
    
    for (NSString *title in titles) {
        YHSegmentItem *item = [[YHSegmentItem alloc] init];
        item.title = title;
        item.font = [UIFont systemFontOfSize:16];
        [self.segmentView addSegmentItem:item];
    }
    
}

- (CommonViewController *)currentVC
{
    return [self.childViewControllers objectAtIndex:[self currentIndex]];
}

- (NSInteger)currentIndex
{
    return self.mineScrollview.contentOffset.x / kScreenSizeWidth;
}


#pragma mark - delegate or block
#pragma mark - scrollviewdelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.segmentView setOffsetWithScrollViewWidth:scrollView.width scrollViewOffset:scrollView.contentOffset.x];
}

#pragma mark - segementdelegate
- (void)segmentView:(YHSegmentView *)segmentView didSelectedAtIndex:(NSInteger)index
{
    [self.mineScrollview setContentOffset:CGPointMake(CGRectGetWidth(self.mineScrollview.frame) * index, 0)];
    [[self currentVC] reloadData];


}

#pragma mark - events




@end
