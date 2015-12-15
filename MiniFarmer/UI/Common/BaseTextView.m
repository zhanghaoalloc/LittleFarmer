//
//  BaseTextView.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/9.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "BaseTextView.h"

@interface BaseTextView ()

@property (nonatomic, strong) UILabel *placeHolderLabel;

@end

@implementation BaseTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.showsHorizontalScrollIndicator = NO;
        
        [self setBackgroundColor:[UIColor blueColor]];
        self.placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.placeHolderLabel.textColor = [UIColor colorWithHexString:@"a3a3a3"];
        self.placeHolderLabel.font = kTextFont(14);
//        self.placeHolderLabel.text = kPlaceHolderText;
        self.placeHolderLabel.numberOfLines = 0;
        [self addSubview:self.placeHolderLabel];
        [self.placeHolderLabel setBackgroundColor:[UIColor redColor]];
        [self.placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.top.equalTo(self.mas_top);
        }];
        
        //添加通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
    }
    return self;
}

- (void)beginEditing:(NSNotification *)notification
{
    [self setPlaceHolderLabelHidden:YES];
}

- (void)hasEndEditing:(NSNotification *)notification
{
    if (!self.text.length)
    {
        [self setPlaceHolderLabelHidden:NO];
    }
}

- (void)setTextViewLineSpace:(CGFloat)lineSpace
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:kTextFont(14),
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    self.attributedText = [[NSAttributedString alloc] initWithString:@"输入你的内容" attributes:attributes];
}

- (void)setPlaceHolderLabelHidden:(BOOL)hidden
{
    [self.placeHolderLabel setHidden:hidden];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
