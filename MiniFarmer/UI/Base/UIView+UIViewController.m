//
//  UIView+UIViewController.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/24.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "UIView+UIViewController.h"


@implementation UIView (UIViewController)

- (UIViewController *)ViewController{
    UIResponder *next = self.nextResponder;
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
        
    } while (next != nil);
    return nil;
}

@end
