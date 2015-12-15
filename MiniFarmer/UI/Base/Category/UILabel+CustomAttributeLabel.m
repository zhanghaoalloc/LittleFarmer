//
//  UILabel+CustomAttributeLabel.m
//  LeSearchSDK
//
//  Created by 尹新春 on 15/3/26.
//  Copyright (c) 2015年 Leso. All rights reserved.
//

#import "UILabel+CustomAttributeLabel.h"


@implementation UILabel (CustomAttributeLabel)

- (void)setTextFont:(UIFont *)font atRange:(NSRange)range
{
    [self setTextAttributes:@{NSFontAttributeName : font}
                    atRange:range];
}

- (void)setTextColor:(UIColor *)color atRange:(NSRange)range
{
    [self setTextAttributes:@{NSForegroundColorAttributeName : color}
                    atRange:range];
}

- (void)setTextLineSpace:(float)space font:(UIFont *)font
{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:space];//调整行间距
    [attributedString addAttributes:@{NSFontAttributeName :font,
                                      NSParagraphStyleAttributeName : paragraphStyle} range:NSMakeRange(0, [self.text length])];
//    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    self.attributedText = attributedString;
//    [self sizeToFit];

    
    
    
    
    
    
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle setLineSpacing:15];
//    
//    [self setTextAttributes:@{NSParagraphStyleAttributeName : paragraphStyle} atRange:range];
//    
//    [self sizeToFit];
}

- (void)setTextFont:(UIFont *)font color:(UIColor *)color atRange:(NSRange)range
{
    [self setTextAttributes:@{NSFontAttributeName : font,
                              NSForegroundColorAttributeName : color}
                    atRange:range];
}

- (void)setTextAttributes:(NSDictionary *)attributes atRange:(NSRange)range
{
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    
    for (NSString *name in attributes)
    {
        [mutableAttributedString addAttribute:name value:[attributes objectForKey:name] range:range];
    }
    // [mutableAttributedString setAttributes:attributes range:range]; error
    
    self.attributedText = mutableAttributedString;
}

- (void)setLayerWithBordWidth:(CGFloat)bordWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius
{
//    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = bordWidth;
    self.layer.borderColor = borderColor.CGColor;
    
}

- (void)setShadow
{
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    shadow.shadowBlurRadius = 2;
    shadow.shadowOffset = CGSizeMake(1, 1);
    NSDictionary *dic = @{NSFontAttributeName:self.font,NSShadowAttributeName:shadow,NSVerticalGlyphFormAttributeName:@(0)};
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[APPHelper safeString:self.text]];
    NSRange range = {0,self.text.length};
    [str setAttributes:dic range:range];
    self.attributedText = str;
    
}


- (void)setShadowWithRadius:(CGFloat)radius
                     offset:(CGSize)offset
                 shaowColor:(UIColor *)shadowColor
{
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = shadowColor;
    
    shadow.shadowBlurRadius = radius;
    shadow.shadowOffset = offset;
    NSDictionary *dic = @{NSFontAttributeName:self.font,NSShadowAttributeName:shadow,NSVerticalGlyphFormAttributeName:@(0)};
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[APPHelper safeString:self.text]];
    NSRange range = {0,self.text.length};
    [str setAttributes:dic range:range];
    self.attributedText = str;
}

- (void)setLabelLineBreadkModelMiddle
{
    self.lineBreakMode = NSLineBreakByTruncatingMiddle;
}

- (void)setLabelLineBreadkModelHead
{
    self.lineBreakMode = NSLineBreakByTruncatingHead;
}

- (void)setLabelLineBreadkModelTail
{
    self.lineBreakMode = NSLineBreakByTruncatingTail;
}


- (CGSize)contentTextSize
{
    if (!self.text)
    {
        return self.bounds.size;
    }
    
//    self.numberOfLines = 0;
    self.lineBreakMode = NSLineBreakByCharWrapping;
    
    CGSize textSize;
    CGSize maximumLabelSize = CGSizeMake(CGFLOAT_MAX, CGRectGetHeight(self.bounds));
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = self.lineBreakMode;
        paragraphStyle.alignment = self.textAlignment;
        // NSStringDrawingTruncatesLastVisibleLine: 如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号。如果指定了NSStringDrawingUsesLineFragmentOrigin选项，则该选项被忽略。
        textSize = [self.text boundingRectWithSize:maximumLabelSize
                                           options:(NSStringDrawingTruncatesLastVisibleLine
                                                    | NSStringDrawingUsesLineFragmentOrigin
                                                    | NSStringDrawingUsesFontLeading)
                                        attributes:@{NSFontAttributeName : self.font,
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
        textSize = [self.text sizeWithFont:self.font constrainedToSize:maximumLabelSize lineBreakMode:self.lineBreakMode];
    }
    
    return textSize;
    
    
}


- (CGSize)contentTextSizeWithFont:(UIFont *)font verticalSpace:(CGFloat)space
{
    if (!self.text)
    {
        return self.bounds.size;
    }
    
    //    self.numberOfLines = 0;
    self.lineBreakMode = NSLineBreakByCharWrapping;
    
    CGSize textSize;
    CGSize maximumLabelSize = CGSizeMake(CGFLOAT_MAX, CGRectGetHeight(self.bounds));
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = self.lineBreakMode;
        paragraphStyle.alignment = self.textAlignment;
        [paragraphStyle setLineSpacing:space];
        // NSStringDrawingTruncatesLastVisibleLine: 如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号。如果指定了NSStringDrawingUsesLineFragmentOrigin选项，则该选项被忽略。
        textSize = [self.text boundingRectWithSize:maximumLabelSize
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
        textSize = [self.text sizeWithFont:self.font constrainedToSize:maximumLabelSize lineBreakMode:self.lineBreakMode];
    }
    
    return textSize;
    
    
}




- (void)attributeLabelWithImage:(UIImage *)image imageSize:(CGSize)imageSize
{
    if (!self.text)
    {
        return;
    }
    self.text = @"多了几分多了几分";
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:self.text];
    
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = image;
    // 设置图片大小
    attch.bounds = CGRectMake(100, 0, imageSize.width, imageSize.height);
    
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attri appendAttributedString:string];
    
    // 用label的attributedText属性来使用富文本
    self.attributedText = attri;
    
}

- (void)attributeLabelWithArray:(NSArray *)arr
{
     NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:self.text];
    for (id object in arr)
    {
        if ([object isKindOfClass:[NSString class]])
        {
            NSAttributedString *attritedString = [[NSAttributedString alloc] initWithString:object];
            [attri appendAttributedString:attritedString];

        }
        else if ([object isKindOfClass:[UIImage class]])
        {
            UIImage *image = (UIImage *)object;
            NSTextAttachment *attch = [[NSTextAttachment alloc] init];
            // 表情图片
            attch.image = image;
            // 设置图片大小
            attch.bounds = CGRectMake(100, 0, image.size.width, image.size.height);
            // 创建带有图片的富文本
            NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
            [attri appendAttributedString:string];
        }
    }
    self.attributedText = attri;
}



@end


