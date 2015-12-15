//
//  MineSegmentCell.h
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/6.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineBaseTableViewCell.h"

@class MineSegmentCell;

@protocol MineSegmentCellDelegate <NSObject>

@optional

- (void)mineSegmentCell:(MineSegmentCell *)cell clickMineSave:(BOOL)clickMineSave;

@end

@interface MineSegmentCell : MineBaseTableViewCell

@property (nonatomic, assign) id <MineSegmentCellDelegate> delegate;

@end
