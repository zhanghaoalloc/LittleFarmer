//
//  DetailView.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/14.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MethodDetailModel.h"
@interface DetailView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *tx;
@property (weak, nonatomic) IBOutlet UILabel *xm;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *ddcs;
@property (weak, nonatomic) IBOutlet UILabel *pfms;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;

@property (nonatomic,strong)MethodDetailModel *model;

@property (nonatomic,assign)CGFloat height;



@end
