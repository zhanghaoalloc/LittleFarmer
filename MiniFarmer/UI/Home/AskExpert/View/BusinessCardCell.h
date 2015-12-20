//
//  BusinessCardCell.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/17.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpertDetailModel.h"
#import "ExpertModel.h"

@interface BusinessCardCell : UITableViewCell{



    __weak IBOutlet UILabel *_invite;

    __weak IBOutlet UILabel *_age;
    
    __weak IBOutlet UILabel *_location;

    __weak IBOutlet UILabel *_good;
    

    __weak IBOutlet UILabel *_introduce;
}

@property(nonatomic,strong)ExpertDetailModel *model;
@property(nonatomic,strong)ExpertModel *expermodel;

+ (CGFloat)countTotalHeigth:(ExpertModel *)heigthModel;
@end
