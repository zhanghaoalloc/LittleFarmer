//
//  MyAnswerCell.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/18.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MyAnswerCell.h"
#import "AnswersButton.h"
#import "PhotoViewController.h"
#import "UIViewAdditions.h"



@implementation MyAnswerCell{

    
    UIView *_outputView;
    UILabel *_contentLabel;

    
    //图片集合view
    UIView *_pictureView;
    UIButton *_firstPicBtn;
    UIButton *_secondPicBtn;
    UIButton *_thirdPicBtn;
    
    //底部view
    UIView *_bottomView;
    UIImageView *_plantImgView;
    UILabel *_plantNameLabel;
    UILabel *_dateLable;
    UIImageView *_userIcon;
    UILabel *_nameLabel;
    
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = RGBCOLOR(238, 238, 238);
        self.selectionStyle =UITableViewCellSelectionStyleNone;
        
        
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
        _contentLabel = [UILabel new];
        //_contentLable.backgroundColor = [UIColor redColor];
        [_outputView addSubview:_contentLabel];
        _contentLabel.font = kTextFont16;
        _contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.numberOfLines = 0;
        
        [self pictureViewInit];
        
        //底部view
        [self bottemViewInit];
        
        
        //[self addViewConstraint];
    }
    
    return self;
}


- (void)pictureViewInit
{
    _pictureView = [UIView new];
    [_outputView addSubview:_pictureView];
    //_pictureView.backgroundColor = [UIColor yellowColor];
    [_pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentLabel.mas_bottom).offset(kPicViewTopPadding);
        make.left.equalTo(self.contentView.mas_left).offset(12);
        make.right.equalTo(self.contentView.mas_right).offset(-12);
        make.height.mas_equalTo(kPicImgHeight);
    }];
    
    _firstPicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _firstPicBtn.tag = 1;
    [_firstPicBtn addTarget:self action:@selector(pictureAction:) forControlEvents:UIControlEventTouchUpInside];
    [_pictureView addSubview:_firstPicBtn];
    
    _secondPicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _secondPicBtn.tag = 2;
    [_secondPicBtn addTarget:self action:@selector(pictureAction:) forControlEvents:UIControlEventTouchUpInside];
    [_pictureView addSubview:_secondPicBtn];
    
    _thirdPicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _thirdPicBtn.tag = 3;
    [_thirdPicBtn addTarget:self action:@selector(pictureAction:) forControlEvents:UIControlEventTouchUpInside];
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
//图片按钮的点击事件
- (void)pictureAction:(UIButton *)button{
    
    PhotoViewController *photoVC = [[PhotoViewController alloc] init];
    
    photoVC.indexPath =[NSIndexPath indexPathForItem:button.tag inSection:0];
    self.viewController.tabBarController.hidesBottomBarWhenPushed = YES;
    QuestionInfo *info = _qSource.qInfo;
    photoVC.imageUrls =info.images.mutableCopy;
    
    [self.viewController.navigationController pushViewController:photoVC animated:YES];
    
}

- (void)bottemViewInit
{
    _bottomView = [UIView new];
    [_outputView addSubview:_bottomView];
   
    
    //植物图标
    _plantImgView = [UIImageView new];
    [_bottomView addSubview:_plantImgView];
    
    _plantNameLabel = [UILabel new];
    [_bottomView addSubview:_plantNameLabel];
    //_plantNameLabel.backgroundColor = [UIColor blueColor];
    _plantNameLabel.textColor = kTextLightBlackColor;
    _plantNameLabel.font = kTextFont12;
    
    //时间
    //日期
    _dateLable = [UILabel new];
    [_bottomView addSubview:_dateLable];
    
    
    _userIcon = [UIImageView new];
    [_bottomView addSubview:_userIcon];
    
    //用户名
    _nameLabel = [UILabel new];
    [_bottomView addSubview:_nameLabel];
    _nameLabel.font = kTextFont14;
    _nameLabel.textColor = kTextBlackColor;
    
   
    
}

- (void)updateBottemView
{
    __weak MyAnswerCell *wself = self;
    [_bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        UIView *tmpView;
        if (wself.qSource.qInfo.images.count == 0) {
            tmpView =_contentLabel;
        }
        else
        {
            tmpView = _pictureView;
        }
        make.top.equalTo(tmpView.mas_bottom);
        make.left.equalTo(_outputView).offset(kLeftSpace);
        
        make.right.equalTo(_outputView).offset(-kRightSpace);
        make.height.mas_equalTo(kBottemViewHeight);
    }];
    
    _plantImgView.image = [UIImage imageNamed:@"home_icon_plant"];
    
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
    
    //植物图标和植物名字
    [_plantImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bottomView);
        make.left.equalTo(_bottomView.mas_centerX).offset(20);
        make.size.mas_equalTo(CGSizeMake(26, 26));
    }];
    [_plantNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bottomView);
        make.left.equalTo(_plantImgView.mas_right).offset(5);
        make.height.mas_equalTo(21);
    }];
    //时间
    
    _dateLable.textColor = kTextLightBlackColor;
    _dateLable.font = kTextFont12;
    [_dateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bottomView);
        make.right.equalTo(_bottomView.mas_right).offset(-12);
        make.height.mas_equalTo(21);
    }];
    
}

- (void)updateViewConstraint
{
    [_contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_outputView).offset(kContentTopPadding);
        make.left.equalTo(_outputView).offset(kLeftSpace);
        make.size.mas_equalTo(_qSource.contentLabelSize);
    }];
    
    [self updatePictureView];
    
    [self updateBottemView];
}

- (void)refreshWithQuestionCellSource:(QuestionCellSource *)source
{
    
    _qSource = source;
    
    QuestionInfo *info = _qSource.qInfo;
    _contentLabel.text = info.wtms;
    _plantNameLabel.text = info.zwmc;
    _dateLable.text = [APPHelper describeTimeWithMSec:info.twsj];
    [self updateViewConstraint];
}



@end
