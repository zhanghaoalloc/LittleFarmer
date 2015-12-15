//
//  QusetionSearchViewController.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/3.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "QusetionSearchViewController.h"
#import "SeachView.h"
#import "BaseViewController+Navigation.h"
#import "QuestionCell.h"
#import "UserInfo.h"
#import "QuestionCellSource.h"

#import "QuestionDetailViewController.h"

@interface QusetionSearchViewController ()

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation QusetionSearchViewController{
    SeachView *_seachView;
    
    
    NSString *_identify;
    NSMutableArray *_sourceArr;

}
- (instancetype)init{
    self = [super init];
    if (self) {
        //UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:self];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    [self setNavigationBarIsHidden:NO];
    
    _sourceArr = [NSMutableArray arrayWithCapacity:1];
    //1.创建子视图
     [self _createSubView];
   
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0,kStatusBarHeight,44, 44)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"home_navigation_back_btn"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"home_navigation_back_btn"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setLineToBarBottomWithColor:RGBCOLOR(169, 169, 169) heigth:kLineWidth];
    
    [self.view addSubview:backButton];
    

    
    
}
- (void)backAction:(UIButton *)button{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
- (void)_createSubView{
    //加载未成功的
    [self.view showLoadingWihtText:@"加载中"];
    

    //1.创建搜索栏视图
    _seachView = [[NSBundle mainBundle] loadNibNamed:@"SeachView" owner:self options:nil].lastObject;
    _seachView.frame = CGRectMake(35, kStatusBarHeight, kScreenSizeWidth-35, kNavigationBarHeight);
    _seachView.imageNmae = @"home_btn_message_nm";
    _seachView.isSearch = NO;
    _seachView.index = 1;
    UIView *view = (UIView *)[_seachView viewWithTag:101];
    UITextField *textfild = (UITextField *)[view viewWithTag:201];
    textfild.text = _keyword;

    [self.view addSubview:_seachView];
    
    //2.创建tableView
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight+kNavigationBarHeight, kScreenSizeWidth, kScreenSizeHeight-(kStatusBarHeight+kNavigationBarHeight)) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _identify = @"QuestionCell";
    [_tableView registerClass:[QuestionCell class] forCellReuseIdentifier:_identify];
    _tableView.hidden = YES;
    
    [self.view addSubview:_tableView];
    
    
}
#pragma mark---UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _sourceArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:_identify forIndexPath:indexPath];
    [cell refreshWithQuestionCellSource:(QuestionCellSource *)_sourceArr[indexPath.row]];
    
    
    return cell;
}
#pragma mark----UITableViewdelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionCellSource *curSource = [_sourceArr objectAtIndex:indexPath.row];
    return curSource.cellTotalHeight;
    
    //return [QuestionCell cellHeightWithObject:nil];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUInteger row = indexPath.row;
    QuestionCellSource *tmpSou = [_sourceArr objectAtIndex:row];
    NSString *wtid = tmpSou.qInfo.qid;
    QuestionDetailViewController *quVC = [[QuestionDetailViewController alloc] initWithWtid:wtid];
    [self.navigationController pushViewController:quVC animated:YES];
}



#pragma mark---数据处理
- (void)setKeyword:(NSString *)keyword{
    _keyword = keyword;
    NSString *userid = [UserInfo shareUserInfo].userId;
    if (userid ==nil) {
        userid = @"0";
    }
    NSDictionary * dic = @{
                           @"userid":userid,
                           @"wd":_keyword
                           
                           };
    [self _reqestData:@"?c=search&m=home" with:dic type:SHHttpRequestGet];
    
    
}
- (void)_reqestData:(NSString *)url with:(NSDictionary *)dic type:(NSInteger)typemethod{
    
    __weak QusetionSearchViewController *weself = self;
    
    
    
    [[SHHttpClient defaultClient] requestWithMethod:typemethod subUrl:url parameters:dic prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResult = responseObject;
            BOOL code = [[dicResult objectForKey:@"code"] boolValue];
            NSString *msg = [dicResult objectForKey:@"msg"];
            DLOG(@"code = %d,msg = %@",code,msg);
            if (!code) {
                //显示加载错误提示
                return;
            }else{
                //加载数据成功
                [self.view dismissLoading ];
                _tableView.hidden = NO;
                NSMutableArray *curQuestions = [QuestionInfo arrayOfModelsFromDictionaries:[dicResult objectForKey:@"list"]];
                for (int i= 0; i<curQuestions.count; i++) {
                    QuestionInfo *questioninfo = [curQuestions objectAtIndex:i];
                    QuestionCellSource *item = [[QuestionCellSource alloc] initWithQuestionInfo:questioninfo];
                    [_sourceArr addObject:item];
                }
                [weself.tableView reloadData];
            }
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}



@end
