//
//  AskViewController.h
//  MiniFarmer
//
//  Created by huangjiancheng on 15/10/6.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface AskViewController : BaseViewController<UIActionSheetDelegate>

- (void)changeSelectedVC:(NSInteger)selectedIndex;

@property(nonatomic,copy)NSString *zjid;

@end
