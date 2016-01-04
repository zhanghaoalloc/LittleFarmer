//
//  MineListViewController.m
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/8.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineSaveViewController.h"
#import "YHSegmentView.h"
#import "MineSaveQuestionViewController.h"
#import "MineSaveTechnoliyViewController.h"
#import "UIViewAdditions.h"

@interface MineSaveViewController ()<YHSegmentViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) YHSegmentView *segmentView;
@property (nonatomic, strong) UIScrollView *saveScrollview;



@end

@implementation MineSaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"eeeeee"]];
    [self setBarTitle:@"我的收藏"];
    
    [self.view addSubview:self.segmentView];
    [self.view addSubview:self.focusScrollview];
    [self setupSegmentItem];
    [self.segmentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view.mas_top).offset(self.yDispaceToTop);
        make.size.mas_equalTo(CGSizeMake(kScreenSizeWidth, 47));
    }];
    
    [self addVC];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    AppDelegate *appDelegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate hideTabbar];
}

- (void)addVC
{
    MineSaveQuestionViewController *questionVC = [[MineSaveQuestionViewController alloc] init];
    [self.focusScrollview addSubview:questionVC.view];
    [self addChildViewController:questionVC];
    questionVC.view.frame = CGRectMake(0,0, kScreenSizeWidth, kScreenSizeHeight - self.yDispaceToTop);
    //    self.expertVC.tableView.frame = self.expertVC.view.bounds;
    
    MineSaveTechnoliyViewController *techVC = [[MineSaveTechnoliyViewController alloc] init];
    [self.focusScrollview addSubview:techVC.view];
    [self addChildViewController:techVC];
    techVC.view.frame = CGRectMake(kScreenSizeWidth,0, kScreenSizeWidth, kScreenSizeHeight - self.yDispaceToTop);
    [questionVC reloadData];
}


- (UIScrollView *)focusScrollview
{
    if (!_saveScrollview)
    {
        _saveScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.yDispaceToTop + 47, kScreenSizeWidth, kScreenSizeHeight - self.yDispaceToTop - 47)];
        _saveScrollview.contentSize = CGSizeMake(2 * kScreenSizeWidth, CGRectGetHeight(_saveScrollview.frame));
        _saveScrollview.bounces = NO;
        _saveScrollview.delegate = self;
    }
    return _saveScrollview;
}


- (void)setupSegmentItem
{
    NSArray *titles = @[@"问题",@"技术"];
    
    for (NSString *title in titles) {
        YHSegmentItem *item = [[YHSegmentItem alloc] init];
        item.title = title;
        item.font = [UIFont systemFontOfSize:16];
        [self.segmentView addSegmentItem:item];
    }
}

#pragma mark UIScrollView协议方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
   [self.segmentView setOffsetWithScrollViewWidth:_saveScrollview.width scrollViewOffset:scrollView.contentOffset.x];
}
#pragma mark - YHSegmentViewDelegate
- (void)segmentView:(YHSegmentView *)segmentView didSelectedAtIndex:(NSInteger)index
{
    [[self.childViewControllers objectAtIndex:index] reloadData];
    [self.focusScrollview setContentOffset:CGPointMake(index * kScreenSizeWidth, 0)];
}

#pragma mark - init views
-(YHSegmentView *)segmentView
{
    if (!_segmentView)
    {
        _segmentView = [[YHSegmentView alloc] init];
        _segmentView.backgroundColor = [UIColor whiteColor];
        _segmentView.itemToLeft =(kScreenSizeWidth-32*2)/3 ;
        _segmentView.directionLineHeigth = 1;
        _segmentView.itemsDispace =(kScreenSizeWidth-32*2)/3 ;
        _segmentView.textSelectedColor = [UIColor colorWithHexString:@"#3872f4"];
        _segmentView.textNormalColor = [UIColor colorWithHexString:@"#666666"];
        _segmentView.directionLineColor = [UIColor colorWithHexString:@"#3872f4"];
        _segmentView.bottomLineHeigth = 1;
        _segmentView.bottomLineColor = [UIColor colorWithHexString:@"#eeeeee"];
        _segmentView.delegate = self;
    }
    return _segmentView;
}



@end
