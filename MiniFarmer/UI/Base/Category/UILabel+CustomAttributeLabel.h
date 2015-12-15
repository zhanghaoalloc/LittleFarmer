//
//  UILabel+CustomAttributeLabel.h
//  LeSearchSDK
//
//  Created by 尹新春 on 15/3/26.
//  Copyright (c) 2015年 Leso. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (CustomAttributeLabel)

- (void)setTextFont:(UIFont *)font atRange:(NSRange)range;

- (void)setTextColor:(UIColor *)color atRange:(NSRange)range;

- (void)setTextLineSpace:(float)space font:(UIFont *)font;

- (void)setTextFont:(UIFont *)font color:(UIColor *)color atRange:(NSRange)range;

- (void)setTextAttributes:(NSDictionary *)attributes atRange:(NSRange)range;

- (void)setLayerWithBordWidth:(CGFloat)bordWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius;

- (void)setLabelLineBreadkModelMiddle;

- (void)setLabelLineBreadkModelHead;

- (void)setLabelLineBreadkModelTail;

- (void)setShadow;

- (CGSize)contentTextSize;

- (void)attributeLabelWithImage:(UIImage *)image imageSize:(CGSize)imageSize;

- (void)attributeLabelWithArray:(NSArray *)arr;


- (CGSize)contentTextSizeWithFont:(UIFont *)font verticalSpace:(CGFloat)space;


- (void)setShadowWithRadius:(CGFloat)radius
                     offset:(CGSize)offset
                 shaowColor:(UIColor *)shadowColor;

@end




