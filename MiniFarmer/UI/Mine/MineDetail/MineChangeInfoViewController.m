//
//  MineChangeInfoViewController.m
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/14.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineChangeInfoViewController.h"

@interface MineChangeInfoViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) UITextField *mineTextField;

@property (nonatomic,strong) UITableView *jobTableView;//工作分类视图



@end

@implementation MineChangeInfoViewController{
   
    NSArray *jobarray;
    NSString *_identify1;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setStatusBarColor:[UIColor colorWithHexString:@"f8f8f8"]];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"eeeeee"]];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    [self setBarLeftDefualtButtonWithTarget:self action:@selector(back)];

    [self setLineToBarBottomWithColor:[UIColor colorWithHexString:@"a3a3a3"] heigth:kLineWidth];
    
    
   // [self addSubviews];
    
    [self addGesture];
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
- (UITextField *)mineTextField
{
    if (!_mineTextField)
    {
        _mineTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _mineTextField.layer.cornerRadius = 8;
        _mineTextField.layer.borderColor = [UIColor colorWithHexString:@"e4e4e4"].CGColor;
        _mineTextField.layer.borderWidth = kLineWidth; //也就是0.5dp
        _mineTextField.textColor = [UIColor colorWithHexString:@"333333"];
        _mineTextField.font = kTextFont(16);
        [_mineTextField setBackgroundColor:[UIColor whiteColor]];
        _mineTextField.delegate = self;
    }
    return _mineTextField;
}
- (void)send:(UIButton *)btn
{
    if (!self.mineTextField.text.length)
    {
        [self.view showWeakPromptViewWithMessage:@"不能为空"];
        
    }
    
    NSString *subUrl = @"?c=user&m=edit_personal";
    NSString *userid = [[MiniAppEngine shareMiniAppEngine]userId];
    // 这里怎么区分 传入的是哪些个字段
    NSDictionary *dic = @{
                          @"userid":userid,
                          @"fieldname":self.item.filename,
                          @"fieldvalue":self.mineTextField.text
                          };
    
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestPost subUrl:subUrl parameters:dic prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        BaseModel *baseModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
        if (baseModel.code.intValue)
        {
            [self.view showWeakPromptViewWithMessage:@"修改成功"];
            [self back];
            self.item.subTitle = self.mineTextField.text;
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
#pragma mark - subviews
//*********点击的是昵称，和种植面积的单元格时加载下面的子视图
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
#pragma mark - UITextFiledDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
   
        [_sendButton setEnabled:textField.text.length ? YES : NO];
        return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
    
}
//********点击的是修改职业的的单元格
- (void)changeJob{
    _jobTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,kStatusBarHeight+kNavigationBarHeight, kScreenSizeWidth,200 ) style:UITableViewStylePlain];
    _jobTableView.delegate = self;
    _jobTableView.dataSource = self;
    _identify1 = @"jobcell";
    jobarray = @[@"种植大户",@"技术员",@"业务员",@"经销商",@"其他"];
    [_jobTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:_identify1];
    
     [self.view addSubview:_jobTableView];
    
    
    
}
#pragma mark----UITabeViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return jobarray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell * cell = [_jobTableView dequeueReusableCellWithIdentifier:_identify1 forIndexPath:indexPath];
    cell.textLabel.text = jobarray[indexPath.row];
    cell.textLabel.font = kTextFont16;
    cell.selected = YES;
    

        return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    /*
     NSArray *cellarray = [tableView visibleCells];
    
    for (UITableViewCell *cell in cellarray) {
       
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    */
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 40;
}
//*******点击的是修改作物
- (void)changePlant{
  

}

//通过判断index来选择加载那个子视图
- (void)setIndex:(NSInteger)index{
    _index = index;
    if (index == 0) {//修改图片
        
    }else if(index == 1){//昵称
        [self addSubviews];
        
    }else  if(index == 4){//职位
        [self changeJob];
        
    }else if(index == 5){//种植作物
        [self changePlant];
        
    }else if(index == 6){//种植面积
        [self addSubviews];
    }
}


@end
