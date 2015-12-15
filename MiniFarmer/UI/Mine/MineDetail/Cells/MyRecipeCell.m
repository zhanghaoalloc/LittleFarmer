//
//  MyRecipeCell.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/22.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MyRecipeCell.h"
#import "MyRecipeView.h"
#import "MyRecipeModel.h"

@interface MyRecipeCell ()

@property (nonatomic, strong) MyRecipeView *myRecipeView;

@end

@implementation MyRecipeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setBackgroundColor:[UIColor colorWithHexString:@"#eeeeee"]];
        self.myRecipeView = [[[NSBundle mainBundle] loadNibNamed:@"MyRecipeView" owner:self options:nil] lastObject];
        [self.myRecipeView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.myRecipeView];
        
        [self.myRecipeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(12);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.top.equalTo(self.contentView.mas_top).offset(12);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
    }
    return self;
}

- (void)refreshDataWithModel:(id)model
{
    [self.myRecipeView refreshUIWithModel:model];
}

+ (CGFloat)cellHeightWihtModel:(id)model
{
    //返回计算的高度以及空出来的高度
    
    return [MyRecipeView heigthWithModel:model] + 12;
}

@end
