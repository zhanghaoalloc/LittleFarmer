//
//  NSString+CustomAttributeString.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/22.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "NSString+CustomAttributeString.h"

@implementation NSString (CustomAttributeString)

- (CGSize)contentTextSizeWithVerticalSpace:(CGFloat)space
                                      font:(UIFont *)font
                                      size:(CGSize)size
{
    if (!self)
    {
        return CGSizeMake(0, 0);
    }
    
    //    self.numberOfLines = 0;
//    self.lineBreakMode = NSLineBreakByCharWrapping;
    
    CGSize textSize;
//    CGSize maximumLabelSize = CGSizeMake(CGFLOAT_MAX, CGRectGetHeight(self.bounds));
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//        paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
//        paragraphStyle.alignment = NSTextAlignmentLeft;
        [paragraphStyle setLineSpacing:space];
        
        // NSStringDrawingTruncatesLastVisibleLine: 如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号。如果指定了NSStringDrawingUsesLineFragmentOrigin选项，则该选项被忽略。
        textSize = [self boundingRectWithSize:size
                                           options:(NSStringDrawingTruncatesLastVisibleLine
                                                    | NSStringDrawingUsesLineFragmentOrigin
                                                    | NSStringDrawingUsesFontLeading)
                                        attributes:@{NSFontAttributeName :font,
                                                     NSParagraphStyleAttributeName : paragraphStyle}
                                           context:nil].size;
        textSize.width = ceil(textSize.width);
        textSize.height = ceil(textSize.height);
    }
    else
    {
        //[self setNumberOfLines:0];
        //[self setLineBreakMode:NSLineBreakByWordWrapping];
        
        //CGSize maximumLabelSize = CGSizeMake(self.frame.size.width,kMaxLabelHeight);
//        textSize = [self sizeWithFont:font constrainedToSize:size lineBreakMode:self.lineBreakMode];
    }
    
    return textSize;
}


@end
