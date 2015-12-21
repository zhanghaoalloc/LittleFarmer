//
//  MineChangeInfoViewController.h
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/14.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineBaseViewController.h"
#import "UserMenuItem.h"

typedef void (^ChangeInfoSuceess) (UserMenuItem *item);

@interface MineChangeInfoViewController : MineBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UserMenuItem *item;
@property (nonatomic, copy) ChangeInfoSuceess changeInfoSuceess;

@property (nonatomic ,assign)NSInteger index;


@end
