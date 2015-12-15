//
//  StudydetailCell.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/26.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiseaseView.h"
#import "StudyModel.h"

@interface StudydetailCell : UITableViewCell

@property(nonatomic,assign)BOOL isStudymore;
@property(nonatomic,retain)StudyModel *model;
@property(nonatomic,strong)NSArray *data;

@end
