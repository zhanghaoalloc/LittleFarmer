//
//  StudyViewController.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/24.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "StudyViewController.h"
#import "BaseViewController+Navigation.h"
#import "SeachView.h"
#import "StudtydetailViewController.h"
#import "UIView+FrameCategory.h"
#

@interface StudyViewController ()

@property(nonatomic,strong)UIScrollView *studyScrollview;
@property(nonatomic,strong)YHSegmentView *segmentView;
@property(nonatomic,strong)NSArray *idData;
@property(nonatomic,strong)NSArray *data;


@end

@implementation StudyViewController{

    
    
    SeachView  *_searchView;


}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    self.edgesForExtendedLayout= UIRectEdgeAll;

    [self setNavigationBarIsHidden:NO];
    
   // [self setBarLeftDefualtButtonWithTarget:self action:@selector(backBtnPressed)];
    
    
    [self setNavigation];
    
    
    //[self addSubViews];
    
    //[self setupSegmentItem];
    [self requesetData];
    
    //self.view.backgroundColor = ;
    //配置导航栏和状态栏的底色
    [self initNavigationbgView:[UIColor colorWithHexString:@"#ffffff"]];
    
    

    
}
- (void)viewWillAppear:(BOOL)animated{
    
   
}
- (void)setNavigation{
    [self.view showLoadingWihtText:@"加载中"];
    //1.搜索栏
    _searchView  = [[NSBundle mainBundle] loadNibNamed:@"SeachView" owner:self options:nil].lastObject;
    _searchView.frame = CGRectMake(35,kStatusBarHeight , kScreenSizeWidth-35,kNavigationBarHeigth);
    _searchView.imageNmae = @"home_btn_message_nm";
    _searchView.isSearch = NO;
    _searchView.index = 3;
    
    [self.view addSubview:_searchView];
    
    //2.导航栏返回按钮
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0,kStatusBarHeight,44, 44)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"home_navigation_back_btn"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"home_navigation_back_btn"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(Action:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setLineToBarBottomWithColor:RGBCOLOR(169, 169, 169) heigth:kLineWidth];
    
    [self.view addSubview:backButton];
    //3.导航栏底部分割线
    [self setLineToBarBottomWithColor:[UIColor colorWithHexString:@"#eeeeee"] heigth:1];
    
    
    
}
- (void)Action:(UIButton *)button{
 
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)addSubViews{
    self.view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];

   //1.添加滚动视图
    [self.view addSubview:self.studyScrollview];
   //2.滑块
    [self.view addSubview:self.segmentView];
  
    self.segmentView.frame = CGRectMake(0, self.yDispaceToTop, kScreenSizeWidth, 42);
    
    
    for (int i=0; i<_data.count; i++) {
        StudtydetailViewController *studyDetailVC = [[StudtydetailViewController alloc] init];
        studyDetailVC.view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
       

        [self.studyScrollview addSubview:studyDetailVC.view];
        
        [self addChildViewController:studyDetailVC];
        
        studyDetailVC.bigid = _idData[i];
        
        studyDetailVC.view.frame = CGRectMake(i*kScreenSizeWidth,0, kScreenSizeWidth,kScreenSizeHeight- self.yDispaceToTop);
        
    }
    self.studyScrollview.frame = CGRectMake(0, CGRectGetMaxY(self.segmentView.frame), kScreenSizeWidth, kScreenSizeHeight - self.yDispaceToTop);
    self.studyScrollview.contentSize = CGSizeMake(kScreenSizeWidth*_data.count,CGRectGetHeight(_studyScrollview.frame));
    



}

- (UIScrollView *)studyScrollview
{
    if (!_studyScrollview) {
        _studyScrollview = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _studyScrollview.showsHorizontalScrollIndicator = NO;
        _studyScrollview.showsVerticalScrollIndicator = NO;
        _studyScrollview.delegate = self;
        _studyScrollview.pagingEnabled = YES;
    }
    return _studyScrollview;
}

- (YHSegmentView *)segmentView
{
    if (!_segmentView)
    {
        _segmentView = [[YHSegmentView alloc] init];
        _segmentView.itemToLeft =(kScreenSizeWidth-(32 *6))/7;
        _segmentView.directionLineHeigth = 1;
        _segmentView.itemsDispace = (kScreenSizeWidth-(32 *6))/7;
        _segmentView.textSelectedColor = [UIColor colorWithHexString:@"#3872f4"];
        _segmentView.backgroundColor = [UIColor whiteColor];
        _segmentView.textNormalColor = [UIColor colorWithHexString:@"666666"];
        _segmentView.directionLineColor = [UIColor colorWithHexString:@"#3872f4"];
        _segmentView.bottomLineHeigth = 1;
        _segmentView.bottomLineColor = [UIColor colorWithHexString:@"#eeeeee"];
        _segmentView.delegate = self;

        
        
    }
    return _segmentView;
}
- (void)setupSegmentItem
{
    
    
    for (NSString *title in _data) {
        YHSegmentItem *item = [[YHSegmentItem alloc] init];
        item.title = title;
        item.font = [UIFont systemFontOfSize:16];
        [self.segmentView addSegmentItem:item];
    }
    
}
//返回当前控制器
- (StudtydetailViewController *)currentVC
{
    return [self.childViewControllers objectAtIndex:[self currentIndex]];
}
//返回当前item
- (NSInteger)currentIndex
{
    return self.studyScrollview.contentOffset.x / kScreenSizeWidth;
}

#pragma mark  ---UIScrollView协议方法

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.segmentView setOffsetWithScrollViewWidth:scrollView.width scrollViewOffset:scrollView.contentOffset.x];
    
   
    
}
#pragma mark  ---- UISegementdelegate协议
- (void)segmentView:(YHSegmentView *)segmentView
 didSelectedAtIndex:(NSInteger)index{
    [self.studyScrollview setContentOffset:CGPointMake(CGRectGetWidth(self.studyScrollview.frame) * index, 0)];
     [[self currentVC].tableView reloadData];
    

}

- (void)backBtnPressed{
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark ---请求网络数据
- (void)requesetData{
    
    
    
    __weak StudyViewController *wself =  self;
    
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestPost subUrl:@"?c=wxjs&m=getzwbigclass" parameters:nil prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
    
        //刷新UI
        dispatch_async(dispatch_get_main_queue(),^{
            
            [self.view dismissLoading];
            NSDictionary *dic = responseObject[@"zwzl"];
            wself.idData = [dic allKeys];
            wself.data = [dic allValues];
            [wself addSubViews];
            [wself setupSegmentItem];
        });
        return ;
    
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
