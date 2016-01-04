//
//  MineResponseImagesCell.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/19.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineAskQuestionImagesCell.h"
#import "MyAskQuestionModel.h"
#import "ZLPhoto.h"
#import "UIViewAdditions.h"


#define kCountOfRow 3
#define kItemsDispace 3
#define kDwidth ceilf((kScreenSizeWidth - 12 * 2 - (kCountOfRow - 1)* kItemsDispace) / kCountOfRow)

@interface MineAskQuestionImagesCell ()
@property (nonatomic, strong) UIView *backContentView;
//内容label
@property (nonatomic, strong) UILabel *contentLabel;
//信息
@property (nonatomic, strong) UILabel *messageCountLabel;
//时间
@property (nonatomic, strong) UILabel *timeLabel;
//中间的分割线
@property (nonatomic, strong) UIImageView *imageLine;
///消息的图片
@property (nonatomic, strong) UIButton *messageBT;

@property (nonatomic, strong) NSMutableArray *imageButtons;

@property (nonatomic, strong) UIButton *imagesCountBT;

@property (nonatomic ,strong) NSMutableArray *photos;

@end



@implementation MineAskQuestionImagesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];

        self.imageButtons = [NSMutableArray arrayWithCapacity:3];
        
        self.backContentView = [[UIView alloc] initWithFrame:CGRectZero];

        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.messageCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.imageLine = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.messageBT = [UIButton buttonWithType:UIButtonTypeCustom];
        self.imagesCountBT = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.imagesCountBT setBackgroundColor:[UIColor blackColor]];
        [self.imagesCountBT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        self.contentLabel.font = kTextFont(16);
        self.timeLabel.font = kTextFont(14);
        self.messageCountLabel.font = kTextFont(14);
        [self.contentLabel setTextColor:[UIColor colorWithHexString:@"333333"]];
        
//        self.contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
        self.contentLabel.numberOfLines = 0;
        [self.timeLabel setTextColor:[UIColor colorWithHexString:@"999999"]];
        [self.messageCountLabel setTextColor:[UIColor colorWithHexString:@"999999"]];
        [self.imageLine setBackgroundColor:[UIColor colorWithHexString:@"e4e4e4"]];
        [self.messageBT setBackgroundImage:[UIImage imageNamed:@"mine_response_btn_nm"] forState:UIControlStateNormal];
        [self.imagesCountBT.titleLabel setFont:kTextFont(10)];

      
        [self.contentView addSubview:self.backContentView];
        [self.backContentView addSubview:self.contentLabel];
        [self.backContentView addSubview:self.messageCountLabel];
        [self.backContentView addSubview:self.timeLabel];
        [self.backContentView addSubview:self.imageLine];
        [self.backContentView addSubview:self.messageBT];
        
        //添加约束
        [self addButtons];
        [self.backContentView addSubview:self.imagesCountBT];

        [self addConstraintsToSubviews];
        
    }
    return self;
}

- (void)addButtons
{
    for (int i = 0; i < kCountOfRow; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(tapBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.backContentView addSubview:button];
        [self.imageButtons addObject:button];
    }
}


- (void)addConstraintsToSubviews
{
    
    [self.backContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backContentView.mas_left).offset(12);
        make.right.equalTo(self.backContentView.mas_right).offset(-12);
        make.top.equalTo(self.backContentView.mas_top).offset(12);
    }];
    
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backContentView.mas_right).offset(-14);
        make.bottom.equalTo(self.line.mas_bottom).offset(-20);
    }];
    
    [self.imageLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.timeLabel.mas_left).offset(-20);
        make.centerY.equalTo(self.timeLabel.mas_centerY).offset(0);
        make.width.equalTo(@(kLineWidth));
        make.height.equalTo(@14);
    }];
    
    
    [self.messageCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imageLine.mas_left).offset(-20);
        make.centerY.equalTo(self.timeLabel.mas_centerY).offset(0);
    }];
    
    [self.messageBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.messageCountLabel.mas_left).offset(-8);
        make.centerY.equalTo(self.timeLabel.mas_centerY).offset(0);
    }];
    
    CGFloat dwidth = kDwidth;
    //buttons的约束
    for (int i = 0; i<self.imageButtons.count; i++)
    {
        UIButton *btn = [self.imageButtons objectAtIndex:i];
        btn.tag = i+1;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(14);
            make.left.equalTo(self.backContentView).offset(12 + i *(dwidth + kItemsDispace));
            make.width.equalTo(@(dwidth));
            make.height.equalTo(@(dwidth));
        }];
        
        
    }
    UIButton *btn = self.imageButtons.lastObject;
    
    [self.imagesCountBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(btn.mas_right).offset(-4);
        make.bottom.equalTo(btn.mas_bottom).offset(- 4);
    }];
//
    
}
#pragma mark---图片浏览
//图片按钮的点击事件
- (void)tapBtn:(UIButton *)btn
{       //图片浏览器
    ZLPhotoPickerBrowserViewController *pickerBrowser = [[ZLPhotoPickerBrowserViewController alloc] init];
    // pickerBrowser.delegate = self;
    // 数据源可以不传，传photos数组 photos<里面是ZLPhotoPickerBrowserPhoto>
    pickerBrowser.photos = self.photos;
    // 是否可以删除照片
    pickerBrowser.editing = NO;
    // 当前选中的值
    pickerBrowser.currentIndexPath = [NSIndexPath indexPathForRow:btn.tag-1 inSection:0];
    // 展示控制器
    [pickerBrowser showPickerVc:self.viewController];
    
}
- (NSMutableArray *)photos:(NSArray *)array{
    _photos = nil;
    if (!_photos) {
        _photos = [NSMutableArray array];
        
        for (NSString *str in array) {
            //判断路径是否是拼接的
            NSURL *iconURL = [NSURL URLWithString:[APPHelper safeString:str]];
            if([str rangeOfString:@"http://www.enbs.com.cn"].location!= NSNotFound) {
                //有前缀
                iconURL = [NSURL URLWithString:str];
            }else{
                
                NSString *str1 = [kPictureURL stringByAppendingString:str];
                iconURL =[NSURL URLWithString:str1];
            }
            ZLPhotoPickerBrowserPhoto *photo = [[ZLPhotoPickerBrowserPhoto alloc] init]
            ;
            photo.photoURL = iconURL;
            [_photos addObject:photo];
            
        }
    }
    
    return _photos;
}



+ (CGFloat)cellHeightWihtModel:(id)model
{
    MyAskQuestionList *list = (MyAskQuestionList *)model;
    
    if (!list.cellHeigth || list.cellHeigth.intValue == 0)
    {
        CGSize textSize = [APPHelper getStringWordWrappingSize:list.wtms andConstrainToSize:CGSizeMake(kScreenSizeWidth - 24, CGFLOAT_MAX) andFont:kTextFont(16)];
        list.cellHeigth = [NSString stringWithFormat:@"%f",textSize.height];
    }
    
    
    //距离上面距离12 + 内容的高度 + 间距14 + 图片的宽度kdwidth  + 12 + timelabel的高度 + 20 + klinewidth
    return 12 + list.cellHeigth.floatValue + 14 + kDwidth  + 14 + 16 + 20 + kLineWidth;
}

- (void)refreshDataWithModel:(id)model
{
    MyAskQuestionList *list = (MyAskQuestionList *)model;
    
    [self.contentLabel setText:list.wtms];
    [self.messageCountLabel setText:list.hdcs];
    [self.timeLabel setText:[APPHelper describeTimeWithMSec:list.twsj]];
    [self.imagesCountBT setHidden:list.images.count < kCountOfRow];
    NSString *title = [NSString stringWithFormat:@"共%ld张",list.images.count];
    
    [self.imagesCountBT setTitle:title forState:UIControlStateNormal];
    
    [self photos:list.images];
    
    [self setImagesToBtnWithModel:list];
    
}

- (void)setImagesToBtnWithModel:(MyAskQuestionList *)list
{
    for (int i = 0; i<(self.imageButtons.count > list.images.count ? list.images.count : self.imageButtons.count); i++)
    {
        UIButton *btn = [self.imageButtons objectAtIndex:i];
        NSString *name =list.images[i];
        NSURL *imgURL;
        if ([name rangeOfString:@"http://www.enbs.com.cn"].location!= NSNotFound) {
            //有前缀
            imgURL = [NSURL URLWithString:[APPHelper safeString:name]];
        }else{
            NSString *str = [KQusetionURL stringByAppendingString:name];
            imgURL =[NSURL URLWithString:[APPHelper safeString:str]];
        }
        [btn sd_setBackgroundImageWithURL:imgURL forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"Sys_defalut"]];
        [btn setEnabled:YES];
    }
    for (NSInteger j = (self.imageButtons.count - 1); j >= list.images.count; j--)
    {
        UIButton *btn = [self.imageButtons objectAtIndex:j];
        
        [btn setBackgroundImage:nil forState:UIControlStateNormal];
        [btn setEnabled:NO];
    }
}

@end
