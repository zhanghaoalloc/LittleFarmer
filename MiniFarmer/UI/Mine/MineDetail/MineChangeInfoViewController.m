//
//  MineChangeInfoViewController.m
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/14.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineChangeInfoViewController.h"
#import "MineJobTableView.h"
#import "AFNetworking.h"
#import "PlantListModel.h"
#import "BaseViewController+Navigation.h"

@interface MineChangeInfoViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) UITextField *mineTextField;
@property (nonatomic, strong) UITextView *introduceView;

@property (nonatomic,strong) MineJobTableView *jobTableView;//工作分类视图
@property (nonatomic,copy)NSString *fileValue;
@property (nonatomic,copy)UITableView *plantTableView;

@property (nonatomic,strong)NSMutableArray *jobarray;//存放职业和专家类型




@end

@implementation MineChangeInfoViewController{
   
    
    NSString *_identify1;
    NSMutableArray *_plantKindArray;//记录种类
    
    NSMutableArray *_plantSectionArrary;//记录分组
    NSMutableArray *_plantRowArray;//分组具体作物的名字
    NSMutableArray *_selectCell;//存放已点击过的单元格
    NSMutableArray *_selectIndex;//存放已点击过单元格的下标
    
    }

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.jobarray = [NSMutableArray array];
    [self setStatusBarColor:[UIColor colorWithHexString:@"#ffffff"]];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"#eeeeee"]];
    
    [self initNavigationbgView:[UIColor colorWithHexString:@"#ffffff"]];
    self.edgesForExtendedLayout = UIRectEdgeAll;

    
    [self lightStatusBar];
    [self setBarLeftDefualtButtonWithTarget:self action:@selector(back)];

    [self setLineToBarBottomWithColor:[UIColor colorWithHexString:@"a3a3a3"] heigth:kLineWidth];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    AppDelegate *appDelegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate hideTabbar];
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma------mark 发送修改后
//发送按钮
- (UIButton *)sendButton
{
    if (!_sendButton)
    {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendButton setBackgroundImage:[UIImage imageNamed:@"ask_send_btn_no_enable_nm"] forState:UIControlStateDisabled];
        [_sendButton setBackgroundImage:[UIImage imageNamed:@"ask_send_btn_hl"] forState:UIControlStateHighlighted];
        [_sendButton setBackgroundImage:[UIImage imageNamed:@"ask_send_btn_enable_nm"] forState:UIControlStateNormal];
        [_sendButton setTitle:@"保存" forState:UIControlStateNormal];
        _sendButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_sendButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [_sendButton setEnabled:NO];
        [_sendButton addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}
- (void)send:(UIButton *)btn
{
    if (_selectCell != nil) {
        
        NSString *name = _selectCell.firstObject;
        if (_selectCell.count == 1) {
            
            self.fileValue = name;
        }else {
            
            for (int i = 1; i<_selectCell.count; i++) {
                name = [NSString stringWithFormat:@"%@,%@",name,_selectCell[i]];
                
            }
            self.fileValue = name;
        }
    }
    if(_mineTextField !=nil){
        self.fileValue = self.mineTextField.text;
        if (!self.mineTextField.text.length)
        {
            [self.view showWeakPromptViewWithMessage:@"不能为空"];
            
        }
    }
    if (_introduceView != nil) {
        self.fileValue = self.introduceView.text ;
        
    }
    
    NSString *subUrl ;
    NSString *userid = [[MiniAppEngine shareMiniAppEngine]userId];
    NSDictionary *dic ;

    
    
    // 这里怎么区分 传入的是哪些个字段
    if (self.zjid ==nil) {//普通用户
        subUrl = @"?c=user&m=edit_personal";
        dic = @{
                 @"userid":userid,
                 @"fieldname":self.item.filename,
                 @"fieldvalue":self.fileValue
                 };
        
    }else{//专家
        subUrl = @"?c=wwzj&m=edit_zjinfo";
        
        dic = @{
                @"id":self.zjid,
                @"fieldname":self.item.filename,
                @"fieldvalue":self.fileValue
                };
    }
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestPost subUrl:subUrl parameters:dic prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {

        BaseModel *baseModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
        
        if (baseModel.code.intValue)
        {
            [self.view showWeakPromptViewWithMessage:@"修改成功"];
            [self back];

            self.item.subTitle = self.fileValue;
            
            self.changeInfoSuceess(self.item);
        }
        else
        {
            [self.view showWeakPromptViewWithMessage:@"修改失败"];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.view showWeakPromptViewWithMessage:@"修改失败"];
    }];
}
#pragma mark - 修改昵称，位置等普通类型的时候
- (void)addSubviews
{
    [self.view addSubview:self.sendButton];
    [self.view addSubview:self.mineTextField];
    
    [self.mineTextField setTextFieldLeftPaddingForWidth:16];

    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.top.equalTo(self.view.mas_top).offset(kStatusBarHeight + 8);
        make.size.mas_equalTo(CGSizeMake(56, 28));
    }];
    
    [self.mineTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(12);
        make.top.equalTo(self.view.mas_top).offset(self.yDispaceToTop + 20);
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.height.equalTo(@44);
    }];
}
- (UITextField *)mineTextField
{
    if (!_mineTextField)
    {
        _mineTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _mineTextField.layer.cornerRadius = 8;
        _mineTextField.layer.borderColor = [UIColor colorWithHexString:@"e4e4e4"].CGColor;
        _mineTextField.layer.borderWidth = kLineWidth; //也就是0.5dp
        _mineTextField.textColor = [UIColor colorWithHexString:@"#333333"];
        _mineTextField.font = kTextFont(16);
        _mineTextField.text = _item.subTitle;
        [_mineTextField setBackgroundColor:[UIColor whiteColor]];
        _mineTextField.delegate = self;
    }
    return _mineTextField;
}

#pragma mark - UITextFiledDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.fileValue = textField.text;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
        [_sendButton setEnabled:textField.text.length?YES:NO];
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
    
}
#pragma ------mark修改职业
- (void)changeJob{
   self.jobTableView = [[MineJobTableView alloc] initWithFrame:CGRectMake(0,kStatusBarHeight+kNavigationBarHeight, kScreenSizeWidth,200 ) style:UITableViewStylePlain];
    
    self.jobTableView.data = self.jobarray.mutableCopy ;
    self.jobTableView.item = self.item;
    __weak MineChangeInfoViewController *wself = self;
    self.jobTableView.block = ^(NSString *jobName){
       
        wself.fileValue = jobName;
        [wself send:nil];
    };
    [self.view addSubview:self.jobTableView];
}
- (void)requestExpertTypeArray{
    
    __weak MineChangeInfoViewController *wself = self;
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestGet subUrl:@"?c=wwzj&m=get_zjlx_list" parameters:nil prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *code = [responseObject objectForKey:@"code"];
        
        if ([code integerValue]==1) {
            
            NSArray *array = [responseObject objectForKey:@"list"];
            
            for (NSDictionary *dic  in array) {
                NSString *lxnc = [dic objectForKey:@"lxnc"];
            
                [wself.jobarray addObject:lxnc];
            }
             [wself changeJob];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma----- mark修改作物
- (void)changePlant{
     [self.view addSubview:self.sendButton];
    
     [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.top.equalTo(self.view.mas_top).offset(kStatusBarHeight + 8);
        make.size.mas_equalTo(CGSizeMake(56, 28));
      }];
    self.sendButton.enabled = YES;

    _plantTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight+kStatusBarHeight, kScreenSizeWidth, kScreenSizeHeight-(kNavigationBarHeight+kStatusBarHeight)) style:UITableViewStyleGrouped];
    _plantTableView.delegate = self;
    _plantTableView.dataSource = self;
    
    [self.view addSubview:_plantTableView];
    
    _identify1 = @"plantCell";
    [_plantTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:_identify1];
}
//作物种类的列表
- (void)requestPlantData{
    _plantKindArray = [NSMutableArray array];
    _plantSectionArrary = [NSMutableArray array];
    _plantRowArray = [NSMutableArray array];
    
    _selectCell = [NSMutableArray array];
    _selectIndex = [NSMutableArray array];

    __weak MineChangeInfoViewController *wself =self;
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestGet subUrl:@"?c=wwzj&m=zwclasslist" parameters:nil prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSString *str = [responseObject objectForKey:@"code"];
        NSInteger i = [str integerValue];
        if (i==1) {
            
            NSDictionary *dic = [responseObject objectForKey:@"sczw"];
            //分类的名字
            _plantKindArray = [dic allKeys].mutableCopy;
            
            for (NSString *name in _plantKindArray) {
                
                [_plantRowArray removeAllObjects];
                
                NSArray *array = [dic objectForKey:name];
                
                for (NSDictionary *plantDic in array) {
                    
                    PlantListModel *model = [[PlantListModel alloc] initContentWithDic:plantDic];
                    [_plantRowArray addObject:model];
                }
                NSArray *smallArray = _plantRowArray.mutableCopy;
                [_plantSectionArrary addObject:smallArray];
            }
            //回主线程
            //回到主线程刷新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                [wself changePlant];
            });
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
    
}
#pragma mark----PlantTableView的协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * array =[_plantSectionArrary objectAtIndex:section];

    return array.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return _plantSectionArrary.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_identify1 forIndexPath:indexPath];
    NSArray *array = [_plantSectionArrary objectAtIndex:indexPath.section];
    PlantListModel *model = array[indexPath.row];
    cell.textLabel.text = model.classname;
    if (_selectIndex == nil) {
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }else{
 
        for (NSIndexPath * selectIndexpath in _selectIndex) {
            if (selectIndexpath == indexPath) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
        
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString *str = _plantKindArray[section];

    return str;

}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 30;

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.000001;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    NSString *title = cell.textLabel.text;

    [_selectCell addObject:title];
    [_selectIndex addObject:indexPath];
    
}
#pragma mark---修改个人简介
- (void)changeSelfIntroduce{
    
    [self.view addSubview:self.sendButton];
    [self.view addSubview:self.introduceView];
    
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.top.equalTo(self.view.mas_top).offset(kStatusBarHeight + 8);
        make.size.mas_equalTo(CGSizeMake(56, 28));
    }];
    
    [self.introduceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(12);
        make.top.equalTo(self.view.mas_top).offset(self.yDispaceToTop + 20);
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.height.equalTo(@200);
    }];
}
#pragma mark--UITextViewDelagate
- (UITextView *)introduceView{
    if (_introduceView ==nil) {
        _introduceView = [[UITextView  alloc] initWithFrame:CGRectZero];
        _introduceView.delegate = self;
        _introduceView.layer.cornerRadius = 8;
        _introduceView.layer.borderWidth = kLineWidth; //也就是0.5dp
        _introduceView.textColor = [UIColor colorWithHexString:@"#333333"];
        _introduceView.font = kTextFont(16);
        _introduceView.text = _item.subTitle;
        _introduceView.layer.borderColor = [[UIColor colorWithHexString:@"#dddddd"]CGColor];
        [_introduceView setBackgroundColor:[UIColor whiteColor]];
    }

    return _introduceView;
}
//结束编辑
- (void)textViewDidEndEditing:(UITextView *)textView{
    
    self.fileValue = textView.text;

}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    [_sendButton setEnabled:textView.text.length?YES:NO];
    
    return YES;
   
}
#pragma mark ---用以选择加载哪种视图
//通过判断index来选择加载那个子视图
- (void)setIndex:(NSInteger)index{
    _index = index;
    
    if (self.zjid !=nil ) {
        [self changeExpert];
    }else{
        [self changeCommon];
    }
}
- (void)changeExpert{
    if (_index == 0) {//修改图片
    }else if(_index == 2){//年龄
        self.sendButton = nil;
        [self addSubviews];
        
    }else  if(_index ==3){//地址
        self.sendButton = nil;
        [self addSubviews];
        
    }else if(_index == 4){//联系电话
        self.sendButton = nil;
        [self addSubviews];
        
    }else if(_index == 5){//专家类型
        self.sendButton = nil;
        
        [self requestExpertTypeArray];
       
    }else if(_index == 6){//擅长作物
        [self requestPlantData ];

    }else if(_index == 7){//工作单位
        self.sendButton = nil;
        [self addSubviews];
    
    }else if(_index == 8){//个人简介
      
        [self changeSelfIntroduce];
        
    }
}
- (void)changeCommon{
    //在普通用户的前提下
    if (_index == 0) {//修改图片
    }else if(_index == 1){//昵称
        self.sendButton = nil;
        [self addSubviews];
        
    }else  if(_index == 4){//职位
       self.
        jobarray = @[@"种植大户",@"技术员",@"业务员",@"经销商",@"其他"].mutableCopy;
        
        [self changeJob];
        
    }else if(_index == 5){//种植作物
        [self requestPlantData];
        
    }else if(_index == 6){//种植面积
        self.sendButton = nil;
        
        [self addSubviews];
    }

}



@end
