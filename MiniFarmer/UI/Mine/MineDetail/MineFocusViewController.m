//
//  MineFocusViewController.m
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/8.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineFocusViewController.h"
#import "YHSegmentView.h"
#import "MIneExpertViewController.h"
#import "MineFocusFriendViewController.h"

@interface MineFocusViewController ()<YHSegmentViewDelegate>

@property (nonatomic, strong) YHSegmentView *segmentView;
@property (nonatomic, strong) UIScrollView *focusScrollview;
@property (nonatomic, strong) MIneExpertViewController *expertVC;
@property (nonatomic, strong) MineFocusFriendViewController *friendVC;


@end

@implementation MineFocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"eeeeee"]];
    [self setBarTitle:@"关注的人"];
    
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

- (void)addVC
{
    MIneExpertViewController *expertVC = [[MIneExpertViewController alloc] init];
    [self.focusScrollview addSubview:expertVC.view];
    [self addChildViewController:expertVC];
    expertVC.view.frame = CGRectMake(0,0, kScreenSizeWidth, kScreenSizeHeight - self.yDispaceToTop);
//    self.expertVC.tableView.frame = self.expertVC.view.bounds;
    
    MineFocusFriendViewController *friendVC = [[MineFocusFriendViewController alloc] init];
    [self.focusScrollview addSubview:friendVC.view];
    [self addChildViewController:friendVC];
    friendVC.view.frame = CGRectMake(kScreenSizeWidth,0, kScreenSizeWidth, kScreenSizeHeight - self.yDispaceToTop);
    [expertVC reloadData];
}


- (UIScrollView *)focusScrollview
{
    if (!_focusScrollview)
    {
        _focusScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.yDispaceToTop + 47, kScreenSizeWidth, kScreenSizeHeight - self.yDispaceToTop - 47)];
        _focusScrollview.contentSize = CGSizeMake(2 * kScreenSizeWidth, CGRectGetHeight(_focusScrollview.frame));
    }
    return _focusScrollview;
}


- (void)setupSegmentItem
{
    NSArray *titles = @[@"专家",@"农友"];
    
    for (NSString *title in titles) {
        YHSegmentItem *item = [[YHSegmentItem alloc] init];
        item.title = title;
        item.font = [UIFont systemFontOfSize:16];
        [self.segmentView addSegmentItem:item];
    }
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
        _segmentView.itemToLeft = 64;
        _segmentView.directionLineHeigth = 4;
        _segmentView.itemsDispace = 110;
        _segmentView.textSelectedColor = [UIColor colorWithHexString:@"#ff6633"];
        _segmentView.textNormalColor = [UIColor colorWithHexString:@"#666666"];
        _segmentView.directionLineColor = [UIColor colorWithHexString:@"#ff6633"];
        _segmentView.bottomLineHeigth = 1;
        _segmentView.bottomLineColor = [UIColor colorWithHexString:@"#e4e4e4"];
        _segmentView.delegate = self;
    }
    return _segmentView;
}




@end
