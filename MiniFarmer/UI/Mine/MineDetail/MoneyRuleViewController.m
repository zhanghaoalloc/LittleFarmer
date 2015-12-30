//
//  MoneyRuleViewController.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/25.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MoneyRuleViewController.h"
#import "BaseViewController+Navigation.h"
#import "MoneyRuleCell.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface MoneyRuleViewController ()


@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *headerView;

@property(nonatomic,strong)NSMutableArray *data;

@end

@implementation MoneyRuleViewController{

    NSString *identify;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    [ self setNavigationBarIsHidden:NO];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];

    [self initTitleLabel:@"农人币规则"];
    
    [self initnavigationBack];
    [self initData];
    
    [self _createSubview];
    

    
}

- (void)initnavigationBack{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0,kStatusBarHeight,44, 44)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"home_navigation_back_btn"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"home_navigation_back_btn"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(popVC) forControlEvents:UIControlEventTouchUpInside];
    
    [self setLineToBarBottomWithColor:RGBCOLOR(169, 169, 169) heigth:0.5];
    
    [self.view addSubview:backButton];
}
- (void)popVC{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)_createHeaderView{
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0 , kScreenSizeWidth,76)];
    _headerView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    
    UIView *fristView = [self ruleView:@"100农人币=1元人民币"];
    fristView.frame = CGRectMake(0, 0, kScreenSizeWidth, 38);
    [_headerView addSubview:fristView];
    UIView *secondView = [self ruleView:@"可直接兑换农人币商城中的礼品"];
    secondView.frame = CGRectMake(0,30, kScreenSizeWidth, 38);
    [_headerView addSubview:secondView];
    
}
- (UIView *)ruleView:(NSString *)title{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, 35)];
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(12,18.5, 5, 5)];
    imgV.backgroundColor = [UIColor colorWithHexString:@"#ff6600"];
    imgV.layer.cornerRadius = 2.5;
    imgV.layer.masksToBounds= YES;
    
    [view addSubview:imgV];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(25, 12, kScreenSizeWidth-37, 20)];
    label.font = kTextFont14;
    label.textColor = [UIColor colorWithHexString:@"#333333"];
    label.text = title;
    
    [view addSubview:label];
    
    
    return view;



}
- (void)_createSubview{
    [self _createHeaderView];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeigth+kStatusBarHeight, kScreenSizeWidth, kScreenSizeHeight-(kNavigationBarHeigth+kStatusBarHeight)) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.bounces = NO;
    
    [self.view addSubview:_tableView];
    
    identify = @"moneyRules";
    
    UINib *nib = [UINib nibWithNibName:@"MoneyRuleCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:identify];
    
    _tableView.tableHeaderView = _headerView;

}
#pragma mark----UITableView协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _data.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MoneyRuleCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    NSString *content = _data[indexPath.row];
    NSString *number = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    NSDictionary *dic =@{
                         @"number":number,
                         @"content":content
                         };
    cell.dic = dic;
    
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kScreenSizeWidth, 62)];
    view.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    
    UIView *subView= [[UIView alloc] initWithFrame:CGRectMake(0,12, kScreenSizeWidth, 50)];
    subView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [view addSubview:subView];
    UIView *pictureView = [self pictureAndText];
    
    pictureView.frame =CGRectMake((kScreenSizeWidth-140)/2,20, 140, 26);
    //pictureView.center = subView.center;
    
    /*
    CGRect frame = pictureView.frame;
    frame.origin.y = 20;
    pictureView.frame = frame;
    */
    
    [subView addSubview:pictureView];
    
    return view;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 62;
    }else{
        return 0.001;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

     CGFloat heigth =[tableView fd_heightForCellWithIdentifier:identify configuration:^(MoneyRuleCell  *cell) {
         
         NSString *content = _data[indexPath.row];
         NSString *number = [NSString stringWithFormat:@"%ld",indexPath.row+1];
         NSDictionary *dic =@{
                              @"number":number,
                              @"content":content
                              };
         cell.dic =dic;
         
     }];
     return heigth;
}

- (void)initData{
    _data =@[@"手机注册成功即可获得100农人币",
             @"独乐乐不如众乐乐，每天首次邀请好友，您将获得10农人币；每当好友点击您的邀请链接时，您也可得获得1农人币。被点击次数越多，农人币越多，上不封顶，等您来分享哦^_^",
             @"填写好友邀请码，小农人将赠送您和您的好友各200农人币",
             @"授人以鱼不如授人以渔，将小农人中提问、学技术、找配方、店铺名片、农资名片等分享给朋友，小农人对这种传播知识行为也会给予农人币奖励，规则同“邀请好友”",
             @"您在10分钟内回答问题被采纳，小农人对您渊博的知识和敬业的精神表示敬佩，会在原有被提问者采纳奖励的200农人币的基础上，额外再赠送您100农人币以资鼓励",
             @"申请专家，并通过审核将获得600农人币",
             @"在小农人开设店铺，并通过审核将获得1000农人币"

             ].mutableCopy;
    
}
- (UIView *)pictureAndText{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,140,26)];
    
    view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 26, 26)];
    [image setImage:[UIImage imageNamed:@"how"]];
    image.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:image];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30,0,110,26)];
    label.textColor = [UIColor colorWithHexString:@"#333333"];
    label.font = kTextFont14;
    label.text = @"如何获取农人币";
    [view addSubview:label];
    
    return view;
    
    

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
