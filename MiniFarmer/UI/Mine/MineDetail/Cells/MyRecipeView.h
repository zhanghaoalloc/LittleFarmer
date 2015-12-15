//
//  MyRecipeView.h
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/22.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyRecipeView : UIView

- (void)refreshUIWithModel:(id)model;
+ (CGFloat)heigthWithModel:(id)model;

@end
