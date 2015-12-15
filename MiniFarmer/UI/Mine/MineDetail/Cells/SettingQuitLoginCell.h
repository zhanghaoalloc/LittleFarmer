//
//  SettingQuitLoginCell.h
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/16.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineBaseTableViewCell.h"

typedef void(^TapQuilt)(UIButton *btn);

@interface SettingQuitLoginCell : MineBaseTableViewCell

@property (nonatomic, copy)TapQuilt tapQuilt;
@end
