//
//  SortView.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/24.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "SortView.h"


@implementation SortView


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _createButton];
    }
    return self;
    
}
- (UIButton *)_createButton{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //普通状态下的图片
    UIImage *ihpone4_5_nm = [UIImage imageNamed:@"home_search_sort_nm_4s"];
    UIImage *iphone6_nm = [UIImage imageNamed:@"home_search_sort_nm"];
    
    
    //选择下面的图片
    UIImage *iphone4_5_select = [UIImage imageNamed:@"home_search_sort_select_4s"];
    UIImage *iphone6_select = [UIImage imageNamed:@"home_search_sort_select"];
    
    
    if (kScreenSizeWidth >320) {
        //iPhone6及iPhone6plus;
        [button setBackgroundImage:iphone6_nm forState:UIControlStateNormal];
        [button setBackgroundImage:iphone6_select forState:UIControlStateSelected];
        [button setBackgroundImage:iphone6_nm forState:UIControlStateHighlighted];
        
    }else{//iphone5及iPhone4s
        [button setBackgroundImage:ihpone4_5_nm forState:UIControlStateNormal];
        [button setBackgroundImage:iphone4_5_select forState:UIControlStateSelected];
        [button setBackgroundImage:ihpone4_5_nm forState:UIControlStateHighlighted];
        
    
    }
    
        return button;
}

- (void)awakeFromNib{

    _title.textColor = [UIColor colorWithHexString:@"#999999"];
    _title.font = kTextFont14;
    
    _history.textColor = [UIColor colorWithHexString:@"#999999"];
    _history.font = kTextFont14;
    _dividine.backgroundColor = [UIColor colorWithHexString:@"#dddddd"];

    
}
- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    
    NSArray *array = @[@"问题",@"商品",@"技术",@"专家",@"配方"];
    CGFloat itemWith = (kScreenSizeWidth-16*6)/5;
    
    for (int i = 0; i< array.count; i++) {
        NSString *title = array[i];
        UIButton *item = [self _createButton];
        item.tag = i+1;
        item.frame = CGRectMake(i*itemWith +16*(i+1),40,itemWith, 27);
        [item setTitle:title forState:UIControlStateNormal];
        [item setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
       // [item setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateHighlighted];
        [item setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateSelected];
        item.titleLabel.font = kTextFont12;
        [item addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:item];
        
        if (item.tag == _currentIndex) {
            item.selected = YES;
        }
        
    }
   // _currentIndex = 1;

}

- (void)itemAction:(UIButton *)button{
    if (_currentIndex!=button.tag) {
        UIButton *item = (UIButton *)[self viewWithTag:_currentIndex];
        item.selected = NO;
        button.selected = YES
        ;
    }
    _currentIndex = button.tag;


}


@end
