//
//  StudymoreCell.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/26.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudyModel.h"

@interface StudymoreCell : UITableViewCell{


    __weak IBOutlet UILabel *name;

    __weak IBOutlet UILabel *more;


}

@property(nonatomic,retain)StudyModel *model;
@end
