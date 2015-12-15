//
//  MineFoucsExpertCell.m
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/9.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineFoucsExpertCell.h"
#import "MyFoucsExpertView.h"

@interface MineFoucsExpertCell ()

@property (nonatomic , strong) MyFoucsExpertView *myFoucsExpertView;

@property (nonatomic, strong) MineExpertList *jsonModel;

@end


@implementation MineFoucsExpertCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        /// initialize
        [self initialize];
    }
    return self;
}

- (void)setExpertModel:(MineExpertList *)model
{
    if (_jsonModel != model)
    {
        _jsonModel = model;
        
    }
}

- (void)initialize
{
    [self.contentView addSubview:self.myFoucsExpertView];
    [self.myFoucsExpertView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

-(MyFoucsExpertView *)myFoucsExpertView
{
    __weak MineFoucsExpertCell *weakSelf = self;
    if (!_myFoucsExpertView)
    {
        _myFoucsExpertView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MyFoucsExpertView class]) owner:self options:nil] firstObject];
        _myFoucsExpertView.tapAsk = ^()
        {
            [weakSelf tapAsk];
        };
    }
    return _myFoucsExpertView;
}


- (void)tapAsk
{
    self.tapAskMineExpert();
}

+ (CGFloat)cellHeightWihtModel:(id)model
{
    return 86 + kLineWidth;
}

@end
