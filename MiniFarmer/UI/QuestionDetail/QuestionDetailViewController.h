//
//  QuestionDetailViewController.h
//  MiniFarmer
//
//  Created by huangjiancheng on 15/11/8.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "UMSocialSnsService.h"

@interface QuestionDetailViewController : BaseViewController<UMSocialUIDelegate>

- (instancetype)initWithWtid:(NSString *)wtid;

@end
