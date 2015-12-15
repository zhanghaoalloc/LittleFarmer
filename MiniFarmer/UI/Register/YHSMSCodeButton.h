//
//  YHSMSCodeButton.h
//  YHSMSCodeButtonDemo
//
//  Created by 长弓 on 15/6/27.
//  Copyright (c) 2015年 SPSD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHSMSCodeButton;
typedef void(^TouchedBlock)(YHSMSCodeButton *sender);

typedef NSString * (^ChangedBlock)(YHSMSCodeButton *sender,int second);

typedef NSString * (^FinishedBlcok)(YHSMSCodeButton *sender,int second);

@interface YHSMSCodeButton : UIButton

- (void)startWithSecond:(int)totalSecond;

- (void)stop;

- (void)addTouchedBlock:(TouchedBlock)touchBlock;

- (void)didchangedBlock:(ChangedBlock)changeBlock;

- (void)didFinishedBlock:(FinishedBlcok)finishedBlock;

@end
