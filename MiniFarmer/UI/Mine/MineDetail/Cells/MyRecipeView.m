//
//  MyRecipeView.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/22.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MyRecipeView.h"
#import "MyRecipeModel.h"
#import "NSString+CustomAttributeString.h"

@interface MyRecipeView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *supportBT;
@property (weak, nonatomic) IBOutlet UIButton *iconImageBT;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;

@end

@implementation MyRecipeView

- (void)refreshUIWithModel:(id)model
{
    MyRecipeList *list = (MyRecipeList *)model;
    self.titleLabel.text = @"测试数据";
    
}

+ (CGFloat)heigthWithModel:(id)model
{
    MyRecipeList *list = (MyRecipeList *)model;
    //距离上面的高度12+中间的间距12 + 头像高度18 + 中间的间距 18 + 计算内容的高度 + 中间的间距 16 + 图片的高度 图片的宽度是确定的 根据比例算出来图片的高度
    CGSize size = [list.pfms contentTextSizeWithVerticalSpace:8 font:kTextFont(16) size:CGSizeMake(kScreenSizeWidth - 20, CGFLOAT_MAX)];
    //这里只是一个比例 具体的还是要看设计的比例
    return 12 + 18 + 12 + 18 + 18 + size.height + 16 + 260;
}

@end
