//
//  StudyHeaderView.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/29.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DieaseModel.h"

@interface StudyHeaderView : UIView{

    __weak IBOutlet UIImageView *_backgroundView;

    __weak IBOutlet UIImageView *_countView;

    __weak IBOutlet UILabel *_countLabel;
    
    __weak IBOutlet UILabel *_DiseaseName;
    
    __weak IBOutlet UILabel *_diseasedetail;
}
@property(nonatomic,strong)DieaseModel *model;
@property(nonatomic,strong)NSMutableArray *images;





@end
