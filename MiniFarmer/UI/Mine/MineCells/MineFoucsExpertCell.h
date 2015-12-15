//
//  MineFoucsExpertCell.h
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/9.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineBaseTableViewCell.h"
#import "MineExpertModel.h"

typedef void(^TapAskMineExpert) ();

@interface MineFoucsExpertCell : MineBaseTableViewCell

@property (nonatomic, strong, readonly) MineExpertList *jsonModel;
@property (nonatomic, strong) TapAskMineExpert tapAskMineExpert;
- (void)setExpertModel:(MineExpertList *)model;

@end
