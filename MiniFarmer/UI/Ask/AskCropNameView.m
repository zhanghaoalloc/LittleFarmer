//
//  AskCropNameView.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/9.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "AskCropNameView.h"

#import "GCPlaceholderTextView.h"

@interface AskCropNameView ()<UITextViewDelegate>

@property (nonatomic, strong) GCPlaceholderTextView *textView;
@property (nonatomic, strong) UIImageView *topLine;
@property (nonatomic, strong) UIImageView *bottomLine;
@property (nonatomic, strong) UIImageView *cropImageView;
@property (nonatomic, strong) UILabel *cropNameLabel;

@end
@implementation AskCropNameView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubviews];
        
    }
    return self;
}

- (void)addSubviews
{
    [self addSubview:self.topLine];
    [self addSubview:self.bottomLine];
    [self addSubview:self.textView];
    [self addSubview:self.cropImageView]; //宽高都是39dp
    [self addSubview:self.cropNameLabel];
    
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@(kLineWidth));
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@(kLineWidth));
    }];
    
    [self.cropImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.cropNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cropImageView.mas_right).offset(12);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cropNameLabel.mas_right).offset(12);
        make.top.equalTo(self.mas_top).offset(kLineWidth);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom).offset(-kLineWidth);
    }];
//
}


- (GCPlaceholderTextView *)textView
{
    if (!_textView)
    {
        _textView = [[GCPlaceholderTextView alloc] initWithFrame:CGRectZero];
        _textView.textColor = [UIColor colorWithHexString:@"a3a3a3"];
        _textView.font = kTextFont(14);
        _textView.placeholderColor = _textView.textColor;
        _textView.delegate = self;
        //TODO:作物名称 要看了android的以后才可以确定
        _textView.placeholder = @"请输入作物名称";
    }
    return _textView;
}

- (UIImageView *)topLine
{
    if (!_topLine)
    {
        _topLine = [[UIImageView alloc] initWithFrame:CGRectZero];
        _topLine.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    }
    return _topLine;
}

- (UIImageView *)bottomLine
{
    if (!_bottomLine)
    {
        _bottomLine = [[UIImageView alloc] initWithFrame:CGRectZero];
        _bottomLine.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    }
    return _bottomLine;
}

- (UIImageView *)cropImageView
{
    if (!_cropImageView)
    {
        _cropImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _cropImageView.image = [UIImage imageNamed:@"ask_imageview_image"];
    }
    return _cropImageView;
}

- (UILabel *)cropNameLabel
{
    if (!_cropNameLabel)
    {
        _cropNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _cropNameLabel.textColor = [UIColor blackColor];
        _cropNameLabel.font = kTextFont(13);
        _cropNameLabel.text = @"作物名称:";
        
    }
    return _cropNameLabel;
}

- (NSString *)text
{
    return _textView.text;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


@end
