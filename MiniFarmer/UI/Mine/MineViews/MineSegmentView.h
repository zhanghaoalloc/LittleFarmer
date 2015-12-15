//
//  MineSegmentView.h
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/6.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^TapMineSave) ();
typedef void (^TapMineFocus) ();


@interface MineSegmentView : UIView
@property (weak, nonatomic) IBOutlet UIButton *mineSaveBT;

@property (weak, nonatomic) IBOutlet UIButton *mineFocusBT;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mineLineWidth;


@property (copy, nonatomic) TapMineSave tapMineSave;
@property (copy, nonatomic) TapMineFocus tapMineFocus;

@end
