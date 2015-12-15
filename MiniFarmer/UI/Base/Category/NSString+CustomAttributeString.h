//
//  NSString+CustomAttributeString.h
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/22.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CustomAttributeString)
- (CGSize)contentTextSizeWithVerticalSpace:(CGFloat)space
                                      font:(UIFont *)font
                                      size:(CGSize)size;

@end
