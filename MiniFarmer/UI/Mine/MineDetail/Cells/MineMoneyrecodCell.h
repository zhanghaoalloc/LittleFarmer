//
//  MineMoneyrecodCell.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/24.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineMoneymodel.h"

@interface MineMoneyrecodCell : UITableViewCell{

    __weak IBOutlet UILabel *_Content;

    __weak IBOutlet UILabel *_time;
    __weak IBOutlet UILabel *_count;
}
@property(nonatomic,strong)MineMoneymodel *model;

@end
