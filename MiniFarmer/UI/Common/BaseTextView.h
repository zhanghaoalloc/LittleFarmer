//
//  BaseTextView.h
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/9.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseTextView;
@protocol BaseTextViewDelegate <NSObject>

@optional
- (void)baseTextViewDidBeginEditing:(BaseTextView *)baseTextView;
- (void)baseTextViewDidEndEditing:(BaseTextView *)baseTextView;
@end

@interface BaseTextView : UITextView
@property (nonatomic, assign) id <BaseTextViewDelegate>delegate;
@end
