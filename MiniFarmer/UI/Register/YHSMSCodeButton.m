//
//  YHSMSCodeButton.m
//  YHSMSCodeButtonDemo
//
//  Created by 长弓 on 15/6/27.
//  Copyright (c) 2015年 SPSD. All rights reserved.
//

#import "YHSMSCodeButton.h"

@interface YHSMSCodeButton ()

@property (assign, nonatomic) int     second;
@property (assign, nonatomic) int     totalSecond;
@property (strong, nonatomic) NSTimer *timer;

@property (copy  , nonatomic) TouchedBlock  touchBlock;
@property (copy  , nonatomic) ChangedBlock  changedBlcok;
@property (copy  , nonatomic) FinishedBlcok finishedBlcok;

@end

@implementation YHSMSCodeButton


#pragma mark - 对外的接口

- (void)startWithSecond:(int)totalSecond{
    self.totalSecond = totalSecond;
    self.second = totalSecond;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerStart) userInfo:nil repeats:YES];    
}

- (void)stop{
    if (self.timer) {
        if ([self.timer respondsToSelector:@selector(isValid)]) {
            
            [self.timer invalidate];
            self.second = self.totalSecond;
            
            NSString *defaultTile = @"重新获取";
            if (self.finishedBlcok) {
                NSString *title = self.finishedBlcok(self,self.totalSecond);
                if (title.length>0) {
                    [self setTitle:title forState:UIControlStateNormal];
                }else{
                    if ([UIDevice currentDevice].systemVersion.floatValue < 8.0) {
                        self.titleLabel.text = defaultTile;
                    }
                    else
                    {
                        [self setTitle:defaultTile forState:UIControlStateNormal];
                    }
                }
            }else{
                [self setTitle:defaultTile forState:UIControlStateNormal];
            }
        }
    }
}

-(void)addTouchedBlock:(TouchedBlock)touchBlock{
    self.touchBlock = [touchBlock copy];
    [self addTarget:self action:@selector(touched:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didchangedBlock:(ChangedBlock)changeBlock{
    self.changedBlcok = [changeBlock copy];
}

- (void)didFinishedBlock:(FinishedBlcok)finishedBlock{
    self.finishedBlcok = [finishedBlock copy];
}


#pragma mark - click events
- (void)touched:(YHSMSCodeButton *)sender{
    if (self.touchBlock) {
        self.touchBlock(sender);
    }
}

#pragma mark - NSTimer
- (void)timerStart{
    if (self.second == 1) {
        [self stop];
    }
    else
    {
        self.second--;
        NSString *defaultTile = [NSString stringWithFormat:@"%d秒",self.second];
        if (self.changedBlcok) {
            NSString *title = self.changedBlcok(self,self.second);
            if (title.length>0) {
                [self setTitle:title forState:UIControlStateNormal];
            }else{
                [self setTitle:defaultTile forState:UIControlStateNormal];
            }
        }else{
            [self setTitle:defaultTile forState:UIControlStateNormal];
        }
    }
}



@end
