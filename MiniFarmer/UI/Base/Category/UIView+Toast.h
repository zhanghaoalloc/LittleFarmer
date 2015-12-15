//
//  UIView+Toast.h
//  WhatsLive
//
//  Created by 尹新春 on 15/8/14.
//  Copyright (c) 2015年 letv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView ()


@end

@interface UIView (Toast)


- (void)showWeakPromptViewWithMessage:(NSString *)message;

- (void)showLoadingWihtText:(NSString *)text;

- (void)dismissLoading;



@end
