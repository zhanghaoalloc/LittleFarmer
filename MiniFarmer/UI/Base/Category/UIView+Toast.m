//
//  UIView+Toast.m
//  WhatsLive
//
//  Created by 尹新春 on 15/8/14.
//  Copyright (c) 2015年 letv. All rights reserved.
//

#import "UIView+Toast.h"
#import "MBProgressHUD.h"
#define kLoadingTag 989
@implementation UIView (Toast)

- (void)showWeakPromptViewWithMessage:(NSString *)message
{
    UIView *view = [[UIApplication sharedApplication].delegate window];

    MBProgressHUD *hud;
    hud = [[MBProgressHUD alloc] initWithView:view];
    hud.yOffset =0 ;
    [self addSubview:hud];
    hud.labelText = message;
    hud.mode = MBProgressHUDModeText;
    hud.labelFont = [UIFont systemFontOfSize:13];
    hud.labelColor = [UIColor whiteColor];
    hud.margin = 10.0f;
    //hud.opacity = 0.6f;
    hud.color = [UIColor blackColor];
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(2.0f);
    } completionBlock:^{
        [hud removeFromSuperview];
    }];
}

- (void)showLoadingWihtText:(NSString *)text
{
    MBProgressHUD *hud;
    hud = [[MBProgressHUD alloc] initWithView:self];
    hud.color = [UIColor blackColor];
//    hud.dimBackground = YES;
    hud.labelText = text;
    hud.tag = kLoadingTag;
    [self addSubview:hud];
    [hud show:YES];
}

- (void)dismissLoading
{
    MBProgressHUD * hub = (MBProgressHUD *)[self viewWithTag:kLoadingTag];
    if (hub)
    {
        [hub removeFromSuperview];
    }
}

@end
