//
//  MyFoucsExpertView.h
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/8.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineFoucsExpertCell.h"
typedef void(^TapAsk)();

@interface MyFoucsExpertView : UIView

- (void)setObject:(MineFoucsExpertCell *)cell;
@property (nonatomic , strong) TapAsk tapAsk;
@end
