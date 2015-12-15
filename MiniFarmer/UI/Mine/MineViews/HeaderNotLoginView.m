//
//  HeaderLoginView.m
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/6.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "HeaderNotLoginView.h"

@interface HeaderNotLoginView ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIButton *headerIconBT;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineWidth;
@property (weak, nonatomic) IBOutlet UIButton *registerBT;

@property (weak, nonatomic) IBOutlet UIButton *loginBT;
@end


@implementation HeaderNotLoginView
- (IBAction)tapRegisterBT:(id)sender {
    self.tapRegistBT();
}
- (IBAction)tapLoginBT:(id)sender {
    self.tapLoginBT();
}
- (IBAction)tapPhoto:(id)sender {
    self.tapPhotoBT();
}

@end
