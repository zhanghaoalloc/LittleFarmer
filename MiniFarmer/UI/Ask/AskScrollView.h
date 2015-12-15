//
//  AskScrollView.h
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/13.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTPickerInfo.h"

@interface AskScrollView : UIScrollView
- (instancetype)initWithFrame:(CGRect)frame
                       images:(NSMutableArray *)images
                selectedIndex:(NSInteger)selectedIndex;
@end
