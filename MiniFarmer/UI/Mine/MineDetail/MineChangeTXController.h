//
//  MineChangeTXController.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/21.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "BaseViewController.h"
#import "UserMenuItem.h"

@interface MineChangeTXController : BaseViewController<UIScrollViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;

@property (nonatomic, strong) UserMenuItem *item;

@property (nonatomic,copy)NSString *url;

@property (nonatomic,copy)NSString *zjid;

@end
