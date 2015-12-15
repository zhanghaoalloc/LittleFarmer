//
//  DiseaPicViewController.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/27.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "DiseaPicViewController.h"
#import "BaseViewController+Navigation.h"
#import "StudydetailCell.h"
#import "TwoclassMode.h"
#import "UIView+FrameCategory.h"
#import "UserInfo.h"
#import "SeachView.h"


@interface DiseaPicViewController ()
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *data;

@end

@implementation DiseaPicViewController{

    NSString *identify;
    SeachView *_seachView;
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    
    [self setNavigationBarIsHidden:NO];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [self setLineToBarBottomWithColor:[UIColor colorWithHexString:@"#eeeeee"] heigth:1];
    [self.view showLoadingWihtText:@"加载中"];
    
    
   // [self _creaSubView];
    
}
- (void)backBtnPressed{

    [self.navigationController popViewControllerAnimated:YES];

}
- (void)_creaSubView{

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight+kNavigationBarHeight,kScreenSizeWidth, kScreenSizeHeight-(kStatusBarHeight +kNavigationBarHeight)) style:UITableViewStylePlain];
    
    //根据数据的多少来确定滑动视图的高度
    if (_isSearch == YES) {
        CGFloat weiht = (kScreenSizeWidth-36)/3;
        if (self.data.count%3==0) {
            _tableView.height =self.data.count/3*(weiht+16);
        }else {
            _tableView.height =(self.data.count/3+1)*(weiht+16)-1;
            
        }

    }
    
  //  _tableView.backgroundColor = [UIColor redColor];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    identify = @"studydetailcell";
    [self.view addSubview:_tableView];
    [_tableView registerClass:[StudydetailCell class] forCellReuseIdentifier:identify];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0,kStatusBarHeight,44, 44)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"home_navigation_back_btn"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"home_navigation_back_btn"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(Action:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setLineToBarBottomWithColor:RGBCOLOR(169, 169, 169) heigth:kLineWidth];
    
    [self.view addSubview:backButton];
    
    
}
- (void)Action:(UIButton *)button{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark---UITabeView的协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.data.count%3==0) {
        return self.data.count/3;
    }
    
    return (self.data.count/3+1);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StudydetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    cell.isStudymore = YES;
   
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i<3; i++) {
        NSInteger index = indexPath.row*3 +i;
        if (index<self.data.count) {
             [array addObject:self.data[index]];
        }
       
    }
    cell.data =array.mutableCopy;
    
        return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat weiht = (kScreenSizeWidth-36)/3;

    return weiht+16;

}


#pragma mark---数据处理
- (void)setIsSearch:(BOOL)isSearch{
    
    _isSearch = isSearch;
   
    _seachView = [[NSBundle mainBundle] loadNibNamed:@"SeachView" owner:self options:nil].lastObject;
    _seachView.frame = CGRectMake(35, kStatusBarHeight, kScreenSizeWidth-35, kNavigationBarHeight);
    _seachView.imageNmae = @"home_btn_message_nm";
    _seachView.isSearch = NO;
    _seachView.index = 3;
    UIView *view = (UIView *)[_seachView viewWithTag:101];
    UITextField *textfild = (UITextField *)[view viewWithTag:201];
    textfild.text = _keyword;
    [self.view addSubview:_seachView];

}
- (void)setKeyword:(NSString *)keyword{
    _keyword = keyword;
    NSString *userid = [UserInfo shareUserInfo].userId;
    if (userid == nil) {
        userid = @"819";
    }
    NSDictionary *dic = @{
                          @"userid":userid,
                          @"wd":_keyword
                          };
    [self _reqestData:@"?c=search&m=bchjs" with:dic type:SHHttpRequestGet];
}

- (void)setTwoclassid:(NSString *)twoclassid{
    _twoclassid = twoclassid;
    NSDictionary *dic = @{
                          @"twoclassid":_twoclassid
                          };
    [self _reqestData:@"?c=wxjs&m=getlistbytwoclass" with:dic type:SHHttpRequestPost];

}
- (void)_reqestData:(NSString *)url with:(NSDictionary *)dic type:(NSInteger)typemethod{
    
    if (_data ==nil) {
        _data = [NSMutableArray array];
    }
    
    __weak DiseaPicViewController *weself = self;
    
    [[SHHttpClient defaultClient] requestWithMethod:typemethod subUrl:url parameters:dic prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                dispatch_async(dispatch_get_main_queue(),^{
                    [weself.view dismissLoading];
            
                    NSArray *array = responseObject[@"list"];
                    for (NSDictionary *dic in array) {
                        
                        TwoclassMode *model = [[TwoclassMode alloc] initContentWithDic:dic];
                        
                        [weself.data addObject:model];
                        
                    }
                    [weself _creaSubView];
                    
                    [weself.tableView reloadData];

        });
        return ;
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
