//
//  commentView.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/11.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface commentView : UIView<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *commenttext;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;

@end
