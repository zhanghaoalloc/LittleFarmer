//
//  MineSegmentCell.m
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/6.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineSegmentCell.h"
#import "MineSegmentView.h"


@interface MineSegmentCell  ()

@property (nonatomic, strong) MineSegmentView *segmentView;

@end

@implementation MineSegmentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.segmentView = [[[NSBundle mainBundle] loadNibNamed:@"MineSegmentView" owner:self options:nil] lastObject];
        [self.contentView addSubview:self.segmentView];
        [self.segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.edges.equalTo(self.contentView);
            
        }];
        __weak MineSegmentCell *weakself = self;
        self.segmentView.tapMineSave = ^()
        {
            [weakself.delegate mineSegmentCell:weakself clickMineSave:YES];
        };
        
        self.segmentView.tapMineFocus = ^()
        {
            [weakself.delegate mineSegmentCell:weakself clickMineSave:NO];
        };
        
    }
    return self;
}

- (void)refreshDataWithModel:(id)model
{
    
}

+ (CGFloat)cellHeightWihtModel:(id)model
{
    return 56;
}



@end
