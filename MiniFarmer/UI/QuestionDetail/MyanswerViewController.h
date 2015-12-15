//
//  MyanswerViewController.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/7.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "BaseViewController.h"
#import "QuestionInfo.h"

@interface MyanswerViewController : BaseViewController<UIScrollViewDelegate,UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>

@property(nonatomic,strong)QuestionInfo *info;

@property(nonatomic,copy)NSString *wtid;
@end
