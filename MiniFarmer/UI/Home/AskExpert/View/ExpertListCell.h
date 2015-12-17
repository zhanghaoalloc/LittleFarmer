//
//  ExpertListCell.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/16.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpertModel.h"

@interface ExpertListCell : UITableViewCell{


    __weak IBOutlet UIImageView *_icon;

    __weak IBOutlet UILabel *_name;

    __weak IBOutlet UILabel *_type;
    
    
    __weak IBOutlet UILabel *_good;
    
    
    __weak IBOutlet UIButton *_questionbutton;
    
    
}


@property(nonatomic,strong)ExpertModel *model;

@end
