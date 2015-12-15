//
//  LoginViewController.h
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/1.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^LoginBackBlock)();

@interface LoginViewController : BaseViewController

@property (nonatomic, copy) LoginBackBlock loginBackBlock;

@end
