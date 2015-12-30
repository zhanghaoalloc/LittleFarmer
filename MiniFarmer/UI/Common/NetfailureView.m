//
//  NetfailureView.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/27.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "NetfailureView.h"

@implementation NetfailureView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _createSubView];
    }
    return self;

}
- (void)_createSubView{
    self.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 219, 141.5+40)];
    

    view.center = self.center;
     [self addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.height.equalTo(@181.5);
        make.width.equalTo(@219);
        make.bottom.equalTo(self.mas_centerY);
    }];
    
    
    
   
    
    UIImageView *imgV = [[UIImageView alloc] init];
    [imgV setImage:[UIImage imageNamed:@"Networking_failure"]];
    [view addSubview:imgV];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.bounds.size.width, 20)];
    
    
    label.text = @"亲~你的网络不给力哦";
    label.font = kTextFont14;
    label.textColor = [UIColor colorWithHexString:@"#666666"];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view.mas_bottom);
        make.height.equalTo(@20);
        make.right.equalTo(view.mas_right);
        make.left.equalTo(view.mas_left);
        
    }];
    
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(label.mas_top).offset(-20);
        make.right.equalTo(view.mas_right);
        make.left.equalTo(view.mas_left);
    }];
    
    
   

}

@end
