//
//  SettingAboutView.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/16.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "SettingAboutView.h"
#import "SettingModel.h"

@interface SettingAboutView ()
@property (strong, nonatomic) IBOutlet UILabel *TitleL;

@end

@implementation SettingAboutView
- (void)reloadDataWithModel:(id)model
{
    SettingModel *settingModel = (SettingModel *)model;
    self.TitleL.text = settingModel.title;
}

@end
