//
//  TableViewCell.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/14.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PfcommentModel.h"
@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *usertx;
@property (weak, nonatomic) IBOutlet UILabel *xm;

@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *comment;


@property (nonatomic,strong)PfcommentModel *model2;

@end
