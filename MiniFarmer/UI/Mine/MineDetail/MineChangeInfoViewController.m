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

@interface MineChangeInfoViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) UITextField *mineTextField;

@property (nonatomic,strong) MineJobTableView *jobTableView;//工作分类视图
@property (nonatomic,copy)NSString *fileValue;
@property (nonatomic,copy)UITableView *plantTableView;


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
    
    [self setStatusBarColor:[UIColor colorWithHexString:@"f8f8f8"]];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"eeeeee"]];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    [self setBarLeftDefualtButtonWithTarget:self action:@selector(back)];

    [self setLineToBarBottomWithColor:[UIColor colorWithHexString:@"a3a3a3"] heigth:kLineWidth];

   // [self addSubviews];
    
   // [self addGesture];
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
    
    NSString *subUrl = @"?c=user&m=edit_personal";
    NSString *userid = [[MiniAppEngine shareMiniAppEngine]userId];
    
    // 这里怎么区分 传入的是哪些个字段
    NSDictionary *dic = @{
                          @"userid":userid,
                          @"fieldname":self.item.filename,
                          @"fieldvalue":self.fileValue
                          };
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
//********点击的是修改职业的的单元格
- (void)changeJob{
   self.jobTableView = [[MineJobTableView alloc] initWithFrame:CGRectMake(0,kStatusBarHeight+kNavigationBarHeight, kScreenSizeWidth,200 ) style:UITableViewStylePlain];
    self.jobTableView.item = self.item;
    __weak MineChangeInfoViewController *wself = self;
    self.jobTableView.block = ^(NSString *jobName){
       
        wself.fileValue = jobName;
        [wself send:nil];
    };
    [self.view addSubview:self.jobTableView];

}
//*******点击的是修改作物
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
//通过判断index来选择加载那个子视图
- (void)setIndex:(NSInteger)index{
    _index = index;
    if (index == 0) {//修改图片
        
    }else if(index == 1){//昵称
        self.sendButton = nil;
        [self addSubviews];
        
    }else  if(index == 4){//职位
       [self changeJob];
        
    }else if(index == 5){//种植作物
        [self requestPlantData];
        
    }else if(index == 6){//种植面积
        self.sendButton = nil;
        [self addSubviews];
    }
}


@end
