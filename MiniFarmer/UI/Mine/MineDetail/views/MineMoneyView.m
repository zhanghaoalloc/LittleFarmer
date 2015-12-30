//
//  MineMoneyView.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/24.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineMoneyView.h"
#import "UIViewAdditions.h"
#import "MoneyRuleViewController.h"



@implementation MineMoneyView{
    
    //上部的视图
    UIView *_topView;
    UILabel *_moneyCount;
    
    //下部分的视图
    UIView *_bottomView;
    
    UIView *_leftView;
    UIView *_rigthView;
    
    
    

}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;

}
- (void)_createSubViews{
    [self  initTopView];
    
    [self initBottomView];
    
    
    

}
- (void)initTopView{
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 130)];
    _topView.backgroundColor = [UIColor colorWithString:@"#ffffff"];
    [self addSubview:_topView];
    
    //金币标志
    UIImageView *pointImage = [UIImageView new];
    pointImage.image = [UIImage imageNamed:@"gold"];
    pointImage.contentMode = UIViewContentModeScaleAspectFit;

    [_topView addSubview:pointImage];
    //金币Label
    _moneyCount = [UILabel new];
    _moneyCount.font = [UIFont systemFontOfSize:40];
    _moneyCount.text = _point;
    _moneyCount.textColor = [UIColor colorWithHexString:@"#ff6600"];

    _moneyCount.textAlignment = NSTextAlignmentNatural;
    [_topView addSubview:_moneyCount];
    //农人币的label
    UILabel *label = [UILabel new];
    label.textColor = [UIColor colorWithHexString:@"#ff6600"];
    label.font = kTextFont14;
    label.text = @"农人币";

    [_topView addSubview:label];
    
    UIView *view  = [[UIView alloc] initWithFrame:CGRectMake(0,129.5,self.bounds.size.width, 0.5)];
    view.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [_topView addSubview:view];
    
    [pointImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_topView.mas_bottom).offset(-30);
        make.left.equalTo(_topView.mas_left).offset(12);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    
    [_moneyCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_topView.mas_bottom).offset(-20);
        make.left.equalTo(pointImage.mas_right).offset(8);
        //make.height.equalTo(@44);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_topView.mas_bottom).offset(-30);
        make.left.equalTo(_moneyCount.mas_right).offset(8);
       // make.height.equalTo(@18);
    }];
}
- (void)initBottomView{
    
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 130, self.bounds.size.width, 44)];
    [self addSubview:_bottomView];
    
    if (_leftView == nil) {
        //左边视图
        _leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0 , kScreenSizeWidth/2-0.25, 44)];
        UIImageView * leftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gift_shop"]];
        [_leftView addSubview:leftImage];
        UILabel *leftLabel = [[UILabel alloc] init];
        leftLabel.numberOfLines = 1;
        leftLabel.text = @"兑换商城";
        leftLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        leftLabel.font = kTextFont14;
        [_leftView addSubview:leftLabel];
        _leftView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, kScreenSizeWidth/2, 0.5)];
        line.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
        [_leftView addSubview:line];
        
        [_bottomView addSubview:_leftView];
        
        

        [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_leftView.mas_top).offset(12);
            make.centerX.equalTo(_leftView.mas_centerX);
        }];
        
        [leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(21, 21));
            make.top.equalTo(leftLabel.mas_top);
            make.right.equalTo(leftLabel.mas_left).offset(-12);
        }];
        //添加;点击事件
       // UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftViewAction)];
       // [_leftView addGestureRecognizer:tap];
    }
    if (_rigthView == nil){
        //右边视图
        _rigthView = [[UIView alloc] initWithFrame:CGRectMake(kScreenSizeWidth/2-0.25,0, kScreenSizeWidth/2, 44)];
        
       UIImageView *rigthImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rule"]];
        [_rigthView addSubview:rigthImage];
        
       UILabel *rigthLabel = [[UILabel alloc] init];
        rigthLabel.numberOfLines = 1;
        rigthLabel.text = @"农人币规则";
        rigthLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        rigthLabel.font = kTextFont14;
        [_rigthView addSubview:rigthLabel];
        
        _rigthView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];

        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, kScreenSizeWidth/2, 0.5)];
        line.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
        [_rigthView addSubview:line];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rigthViewAction)];
        [_rigthView addGestureRecognizer:tap];
        
        [_bottomView addSubview:_rigthView];
        
        [rigthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_rigthView.mas_top).offset(12);
            make.centerX.equalTo(_rigthView.mas_centerX);
        }];
        
        [rigthImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(21, 21));
            make.top.equalTo(rigthLabel.mas_top);
            make.right.equalTo(rigthLabel.mas_left).offset(-12);
        }];
        

    }
    UIView *centerline = [[UIView alloc] initWithFrame:CGRectMake(kScreenSizeWidth/2-0.25, 2, 0.5, 44-4)];
    centerline.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [_bottomView addSubview:centerline];
    
}
- (void)rigthViewAction{
    
    MoneyRuleViewController *moneyRuleVC = [[MoneyRuleViewController alloc] init];
    [self.viewController.navigationController pushViewController:moneyRuleVC animated:YES];

}
-(void)setPoint:(NSString *)point{
    _point = point;
    [self _createSubViews];

}



@end
