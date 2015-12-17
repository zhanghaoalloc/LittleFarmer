//
//  ReplyViewController.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/10.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "ReplyViewController.h"
#import "BaseViewController+Navigation.h"
#import "AnswerInputView.h"
#import "QuAnswerReplyCell.h"
#import "QuAnswerHeaderView.h"
#import "UIView+FrameCategory.h"


@interface ReplyViewController ()
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)AnswerInputView *inputView;
@property(nonatomic,strong)UIView *bottomLine;

@end

@implementation ReplyViewController{

    NSString *_identify;
    CGFloat _totalHeigth;
    CGFloat _headerHeigth;
    


}
- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNaVIgationBackAction:self action:@selector(backButton:)];
    [self initTitleLabel:@"回复"];
    [self setNavigationBarIsHidden:NO];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self addNotifiction];
    
    
   
    
}
- (void)addNotifiction{
    //1.监听键盘的弹起
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyboardAction:) name:UIKeyboardWillShowNotification object:nil];
    //2.监听键盘的收起
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboardAction:) name:UIKeyboardWillHideNotification object:nil];


}
- (void)backButton:(UIButton *)button{

    [self.navigationController popViewControllerAnimated:YES];

}
- (void)_createSubView{
    
    //1.创建滑动视图
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,kNavigationBarHeight+kStatusBarHeight, kScreenSizeWidth, _totalHeigth+_headerHeigth) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    _identify = @"ReplyCell";
    [_tableView registerClass:[QuAnswerReplyCell class] forCellReuseIdentifier:_identify];
    [self.view addSubview:_tableView];
    
    _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, _tableView.height-0.5, kScreenSizeWidth, 0.5)];
    _bottomLine.backgroundColor = [UIColor colorWithHexString:@"#dddddd"];
    [_tableView addSubview:_bottomLine];
    
    
    
    
    //2.创建输入视图
    if(_inputView == nil)
    {  _inputView = [[NSBundle mainBundle] loadNibNamed:@"AnswerInputView" owner:self options:nil].lastObject;

        _inputView.frame = CGRectMake(0, kScreenSizeHeight-kSystemToolBarHeight, kScreenSizeWidth, kSystemToolBarHeight);
        [self.view addSubview:_inputView];
        _inputView.model = _model;
        _inputView.replymodel = self.replymodel;
        
    }
    
}
#pragma mark----UITableViewDataSoure的协议方,数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return _model.relist.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    QuAnswerReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:_identify forIndexPath:indexPath];
    
    
    ReplyModel *repItem = [_model.relist objectAtIndex:indexPath.row];
    
    [cell refreshWithReplyModel:repItem];
    
    return cell;

}
#pragma mark ---UITableViewDelegate协议
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReplyModel *repItem = [_model.relist objectAtIndex:indexPath.row];
    CGFloat height = [QuAnswerReplyCell cellTotalHightWithReplyModel:repItem];
    return height;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
  
    QuAnswerHeaderView *myHeader = [[QuAnswerHeaderView alloc] init];
    [myHeader refreshWithAnsModel:_model];
    
    return myHeader;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   
    
    CGFloat height = [QuAnswerHeaderView headerHeightWithAnsModel:_model];
    
    return height;

}
#pragma mark---数据处理
- (void)setModel:(QuestionAnsModel *)model{
    _model = model;
    
    //修改tableView的frame
     _headerHeigth  = [QuAnswerHeaderView headerHeightWithAnsModel:_model];
    for (ReplyModel *model in _model.relist) {
        _totalHeigth += [QuAnswerReplyCell cellTotalHightWithReplyModel:model];
    }
    
    _inputView.model = _model;
    
    
    
    [self _createSubView];
    //[self.tableView reloadData];
}
- (void)setReplymodel:(ReplyModel *)replymodel{
    _replymodel = replymodel;
    
    if (_replymodel == nil) {
        return ;
    }
    _inputView.replymodel = _replymodel;
    
}


#pragma mark-----通知绑定的方法
//键盘弹出通知绑定的方法
- (void)showKeyboardAction:(NSNotification *)notification{
    //取得键盘信息
    NSDictionary *userInfo = notification.userInfo;
    //取出字典里面对应key的包装好的结构体valuerect
    NSValue *valuerect = userInfo[UIKeyboardBoundsUserInfoKey];
    //将NSValue类型转为CGRect
    CGRect rect = [valuerect CGRectValue];
    //取到键盘的高度
    CGFloat height = rect.size.height;
    //底部视图向上平移
    _inputView.transform = CGAffineTransformMakeTranslation(0, -height);

}
//键盘收起
- (void)willHideKeyboardAction:(NSNotification *)notification{
    _inputView.transform = CGAffineTransformIdentity;
    
}




@end
