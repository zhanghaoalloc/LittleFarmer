//
//  ShareView.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/29.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DieaseModel.h"
#import "UMSocialSnsService.h"
@interface ShareView : UIView{


    __weak IBOutlet UIButton *_back;
    
    
    __weak IBOutlet UIButton *_gohome;

    __weak IBOutlet UIButton *_collection;
    
    __weak IBOutlet UIButton *_share;
}
@property(nonatomic,assign)BOOL isCollection;
@property(nonatomic,strong)DieaseModel *model;

@property(nonatomic,copy)NSNumber *iscoll;

@end
