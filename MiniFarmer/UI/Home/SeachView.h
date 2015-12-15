//
//  SeachView.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/24.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>





@interface SeachView : UIView<UITextFieldDelegate>{


    __weak IBOutlet UIView *_textView;
    

    __weak IBOutlet UIButton *_message;
}

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *imageNmae;
@property(nonatomic,assign)BOOL isSearch;
@property(nonatomic,assign)NSInteger index;




@end
