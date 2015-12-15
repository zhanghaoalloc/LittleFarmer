//
//  DiseaDetailViewController.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/27.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocialSnsService.h"
#import "UMSocial.h"

@interface DiseaDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UMSocialUIDelegate>

@property(nonatomic,copy)NSString *bchid;
@property(nonatomic,strong)NSArray *data;

@end
