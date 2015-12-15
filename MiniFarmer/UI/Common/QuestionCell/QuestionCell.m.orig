//
//  QuestionCell.m
//  MiniFarmer
//
//  Created by huangjiancheng on 15/10/18.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "QuestionCell.h"
#import "AnswersButton.h"


#define kLeftSpace  12

@interface QuestionCell()
{
    UIView *_outputView;
    UILabel *_contentLable;
    
    //中间view
    UIView *_middleView;
    UIImageView *_plantImgView;
    UILabel *_plantNameLabel;
    UILabel *_dateLable;
    
    //图片集合view
    UIView *_pictureView;
    UIButton *_firstPicBtn;
    UIButton *_secondPicBtn;
    UIButton *_thirdPicBtn;
    
    //底部view
    UIView *_bottomView;
    UIImageView *_userIcon;
    UILabel *_nameLabel;
    UILabel *_locationLabel;
    AnswersButton *_ansBtn;
    AnswersButton *_myAnsBtn;
}

@property (nonatomic,strong)QuestionCellSource *qSource;
@end

@implementation QuestionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = RGBCOLOR(238, 238, 238);
        
        _outputView = [UIView new];
        [self.contentView addSubview:_outputView];
        _outputView.backgroundColor = [UIColor whiteColor];
        [_outputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(kOutputViewTopPadding);
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        }];
        
        //问题描述
        _contentLable = [UILabel new];
        //_contentLable.backgroundColor = [UIColor redColor];
        [_outputView addSubview:_contentLable];
        _contentLable.font = kTextFont16;
        _contentLable.lineBreakMode = NSLineBreakByCharWrapping;
        _contentLable.textColor = [UIColor blackColor];
        _contentLable.numberOfLines = 0;
        
        //
        [self middleViewInit];
        
        [self pictureViewInit];
        
        //底部view
        [self bottemViewInit];
        
        
        //[self addViewConstraint];
    }
    
    return self;
}

- (void)middleViewInit
{
    _middleView = [UIView new];
    //_middleView.backgroundColor = [UIColor greenColor];
    [_outputView addSubview:_middleView];
    [_middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentLable.mas_bottom).offset(kMiddleViewTopPadding);
        make.left.equalTo(_contentLable);
        make.right.equalTo(_outputView.mas_right).offset(-kRightSpace);
        make.height.mas_equalTo(kMiddleViewHeight);
    }];
    
    _plantImgView = [UIImageView new];
    [_middleView addSubview:_plantImgView];
    _plantImgView.image = [UIImage imageNamed:@"home_icon_plant"];
    [_plantImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_middleView);
        make.left.equalTo(_middleView);
        make.size.mas_equalTo(CGSizeMake(26, 26));
    }];
    
    _plantNameLabel = [UILabel new];
    [_middleView addSubview:_plantNameLabel];
    //_plantNameLabel.backgroundColor = [UIColor blueColor];
    _plantNameLabel.textColor = kTextLightBlackColor;
    _plantNameLabel.font = kTextFont12;
    [_plantNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_middleView);
        make.left.equalTo(_plantImgView.mas_right).offset(5);
        make.height.mas_equalTo(kMiddleViewHeight);
    }];
    
    //分隔线
    UILabel *lineLabel = [UILabel new];
    [_middleView addSubview:lineLabel];
    lineLabel.backgroundColor = RGBCOLOR(238, 238, 238);
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_plantNameLabel.mas_right).offset(12);
        make.centerY.equalTo(_middleView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(0.5, 16));
    }];
    
    //日期
    _dateLable = [UILabel new];
    [_middleView addSubview:_dateLable];
    //_dateLable.backgroundColor = [UIColor yellowColor];
    _dateLable.textColor = kTextLightBlackColor;
    _dateLable.font = kTextFont12;
    [_dateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_middleView);
        make.left.equalTo(lineLabel.mas_right).offset(12);
        make.height.mas_equalTo(kMiddleViewHeight);
    }];
}

- (void)pictureViewInit
{
    _pictureView = [UIView new];
    [_outputView addSubview:_pictureView];
    //_pictureView.backgroundColor = [UIColor yellowColor];
    [_pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_middleView.mas_bottom).offset(kPicViewTopPadding);
        make.left.equalTo(_middleView);
        make.right.equalTo(_middleView);
        make.height.mas_equalTo(kPicImgHeight);
    }];
    
    _firstPicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_pictureView addSubview:_firstPicBtn];
    
    _secondPicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_pictureView addSubview:_secondPicBtn];
    
    _thirdPicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_pictureView addSubview:_thirdPicBtn];
    
    [_firstPicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pictureView);
        make.left.equalTo(_pictureView);
        make.right.equalTo(_secondPicBtn.mas_left).offset(-kPicPadding);
        make.width.equalTo(_secondPicBtn);
        make.height.equalTo(_pictureView);
    }];
    
    [_secondPicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pictureView);
        make.left.equalTo(_firstPicBtn.mas_right).offset(kPicPadding);
        make.right.equalTo(_thirdPicBtn.mas_left).offset(-kPicPadding);
        make.width.equalTo(_thirdPicBtn);
        make.height.equalTo(_pictureView);
    }];
    
    [_thirdPicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pictureView);
        make.left.equalTo(_secondPicBtn.mas_right).offset(kPicPadding);
        make.right.equalTo(_pictureView);
        make.width.equalTo(_secondPicBtn);
        make.height.equalTo(_pictureView);
    }];
}

- (void)updatePictureView
{
    NSUInteger picCount = _qSource.qInfo.images.count;
    if (picCount == 0) {
        _pictureView.hidden = YES;
        return;
    }
    else{
        _pictureView.hidden = NO;
    }
    
    NSURL *firImg = [NSURL URLWithString:[APPHelper safeString:[_qSource.qInfo.images objectAtIndex:0]]];
    [_firstPicBtn sd_setImageWithURL:firImg forState:UIControlStateNormal];
    _firstPicBtn.hidden = NO;
    
    _secondPicBtn.hidden = YES;
    if (picCount > 1) {
        NSURL *secImg = [NSURL URLWithString:[APPHelper safeString:[_qSource.qInfo.images objectAtIndex:1]]];
        [_secondPicBtn sd_setImageWithURL:secImg forState:UIControlStateNormal];
        _secondPicBtn.hidden = NO;
    }
    
    _thirdPicBtn.hidden = YES;
    if (picCount > 2) {
        NSURL *thrImg = [NSURL URLWithString:[APPHelper safeString:[_qSource.qInfo.images objectAtIndex:2]]];
        [_thirdPicBtn  sd_setImageWithURL:thrImg forState:UIControlStateNormal];
        _thirdPicBtn.hidden = NO;
    }
}

- (void)bottemViewInit
{
    _bottomView = [UIView new];
    [_outputView addSubview:_bottomView];
    //_bottomView.backgroundColor = [UIColor blueColor];
    
    _userIcon = [UIImageView new];
    [_bottomView addSubview:_userIcon];
    
    //用户名
    _nameLabel = [UILabel new];
    [_bottomView addSubview:_nameLabel];
    _nameLabel.font = kTextFont14;
    _nameLabel.textColor = kTextBlackColor;
    
    //地理位置
    _locationLabel = [UILabel new];
    [_bottomView addSubview:_locationLabel];
    _locationLabel.font = kTextFont12;
    _locationLabel.textColor = kTextLightBlackColor;
    
    //我来回答
    _myAnsBtn = [AnswersButton new];
    [_bottomView addSubview:_myAnsBtn];
    [_myAnsBtn.titleLabel setFont:kTextFont14];
    [_myAnsBtn setTitleColor:kLightBlueColor forState:UIControlStateNormal];
    [_myAnsBtn setImage:[UIImage imageNamed:@"home_btn_myanswer_nm"] forState:UIControlStateNormal];
    //[_myAnsBtn setBackgroundColor:[UIColor yellowColor]];
    [_myAnsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bottomView.mas_right);
        make.centerY.equalTo(_nameLabel);
        make.size.mas_equalTo(CGSizeMake(50, kBottemViewHeight));
    }];
    [_myAnsBtn setTitle:@"回答" forState:UIControlStateNormal];
    
    //分隔线
//    UILabel *lineLabel = [UILabel new];
//    [_bottomView addSubview:lineLabel];
//    lineLabel.backgroundColor = RGBCOLOR(238, 238, 238);
//    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(_myAnsBtn.mas_left).offset(-5);
//        make.centerY.equalTo(_bottomView.mas_centerY);
//        make.size.mas_equalTo(CGSizeMake(0.5, 16));
//    }];

    //回答数
    _ansBtn = [AnswersButton new];
    [_bottomView addSubview:_ansBtn];
    [_ansBtn.titleLabel setFont:kTextFont12];
    [_ansBtn setTitleColor:kTextLightBlackColor forState:UIControlStateNormal];
    [_ansBtn setImage:[UIImage imageNamed:@"home_btn_answers_nm"] forState:UIControlStateNormal];
    //[_ansBtn setBackgroundColor:[UIColor yellowColor]];
    [_ansBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_myAnsBtn.mas_left).offset(-2);
        make.centerY.equalTo(_nameLabel);
        make.size.mas_equalTo(CGSizeMake(40, kBottemViewHeight));
    }];
}

- (void)updateBottemView
{
    __weak QuestionCell *wself = self;
    [_bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        UIView *tmpView;
        if (wself.qSource.qInfo.images.count == 0) {
            tmpView =_middleView;
        }
        else
        {
            tmpView = _pictureView;
        }
        make.top.equalTo(tmpView.mas_bottom);
        make.left.equalTo(_outputView).offset(kLeftSpace);
        //make.size.mas_equalTo(CGSizeMake(kMaxContentWidth, kBottemViewHeight));
        make.right.equalTo(_outputView).offset(-kRightSpace);
        make.height.mas_equalTo(kBottemViewHeight);
    }];

    //TODO:头像
    [_userIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bottomView).offset(9);
        make.left.equalTo(_bottomView);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    _nameLabel.text = _qSource.qInfo.xm;
    [_nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userIcon.mas_right).offset(8);
        make.centerY.equalTo(_userIcon);
        make.size.mas_equalTo(CGSizeMake(_qSource.nameLabelWidth,21));
    }];
    
    _locationLabel.text = _qSource.qInfo.location;
    [_locationLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_right).offset(8);
        make.centerY.equalTo(_nameLabel);
        make.size.mas_equalTo(CGSizeMake(_qSource.locationLabelWidth, 21));
    }];
    
    //回答数
    [_ansBtn setTitle:_qSource.qInfo.hdcs forState:UIControlStateNormal];
}

- (void)updateViewConstraint
{
    [_contentLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_outputView).offset(kContentTopPadding);
        make.left.equalTo(_outputView).offset(kLeftSpace);
        make.size.mas_equalTo(_qSource.contentLabelSize);
    }];
    
    [self updatePictureView];
    
    [self updateBottemView];
}
//TODO:时间描述规则
- (NSString *)describeWithTwsj:(NSString *)twsj
{
    if (!twsj) {
        return @"";
    }
    
    long long curTimeMSec = (long long)([NSDate date].timeIntervalSince1970*1000);
    long long passTimeSec = (curTimeMSec - [twsj longLongValue])/1000;
    if (passTimeSec < 0) {
        return @"1小时前";
    }
    //换算成小时
    NSUInteger hours = (NSUInteger)(passTimeSec/3600);
    if (!hours) {
        return @"1小时前";
    }
    
    NSUInteger days = hours/24;
    if (!days) {
        return [NSString stringWithFormat:@"%lu小时前",(unsigned long)hours];
    }
    
    NSUInteger years = days/365;
    if (!years) {
        return [NSString stringWithFormat:@"%lu天前",(unsigned long)days];
    }
    else{
        return [NSString stringWithFormat:@"%lu年前",(unsigned long)years];
    }
}

- (void)refreshWithQuestionCellSource:(QuestionCellSource *)source
{
    _qSource = source;
    QuestionInfo *info = _qSource.qInfo;
    
    _contentLable.text = info.wtms;
    _plantNameLabel.text = info.zwmc;
    _dateLable.text = [APPHelper describeTimeWithMSec:info.twsj];
    [self updateViewConstraint];
}

+ (CGFloat)cellHeightWithObject:(id)object
{
    
    return 60;
}

@end
