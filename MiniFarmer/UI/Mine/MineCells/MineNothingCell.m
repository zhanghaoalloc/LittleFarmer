//
//  MineNothingCell.m
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/6.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineNothingCell.h"

@implementation MineNothingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    }
    return self;
}

- (void)refreshDataWithModel:(id)model
{
    
}

+ (CGFloat)cellHeightWihtModel:(id)model
{
    return 12;
}

@end
