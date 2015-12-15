//
//  UIScrollView+LGKeyboard.h
//  AgricultureNet
//
//  Created by gft  on 13-11-7.
//  Copyright (c) 2013年 gft . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (LGKeyboard)

- (void)enableAvoidKeyboard;

- (void)disableAvoidKeyboard;
- (void)convertFrameWithView:(UIView *)aview bview:(UIView *)bview cview:(UIView *)cview float1:(CGFloat)float1 float2:(CGFloat)float2;
@end
