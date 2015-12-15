//
//  UITextField+CustomTextField.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/17.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "UITextField+CustomTextField.h"

@implementation UITextField (CustomTextField)

-(void)setTextFieldLeftPaddingForWidth:(CGFloat)leftWidth
{
    CGRect frame = self.frame;
    frame.size.width = leftWidth;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = leftview;
    
}

@end
