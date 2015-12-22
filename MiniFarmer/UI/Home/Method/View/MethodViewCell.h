//
//  MethodViewCell.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/7.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MethodModel.h"

@interface MethodViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *pfmc;
@property (weak, nonatomic) IBOutlet UILabel *zjtj;
@property (weak, nonatomic) IBOutlet UIImageView *tx;
@property (weak, nonatomic) IBOutlet UILabel *xm;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIImageView *datu;
@property (weak, nonatomic) IBOutlet UIImageView *xiaotu1;
@property (weak, nonatomic) IBOutlet UIImageView *xiaotu2;
@property (weak, nonatomic) IBOutlet UIImageView *xiaotu3;
@property (weak, nonatomic) IBOutlet UILabel *ddcs;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (nonatomic,retain)MethodModel *model;



@end
