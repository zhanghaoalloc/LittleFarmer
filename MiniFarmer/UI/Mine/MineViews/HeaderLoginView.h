//
//  HeaderLoginView.h
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/6.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapLoginHeaderPhotoBT)();


@interface HeaderLoginView : UIView


@property (nonatomic ,copy) TapLoginHeaderPhotoBT tapPhotoBT;


- (void)refreshUIWithModel:(id)model;

@end
