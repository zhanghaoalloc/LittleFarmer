//
//  AboutViewController.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/17.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineOneHeigth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineTwoHeigth;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BTToTop;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBarTitle:@"关于小农人"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-  (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.lineOneHeigth.constant = kLineWidth;
    self.lineTwoHeigth.constant = kLineWidth;
}

#pragma mark - configureSubviews



#pragma mark - clickEvent
- (IBAction)tapSupprotBT:(id)sender
{
    DLOG(@"--------- 进入appstore 去点赞");
    //这里跳转到appstore
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms://itunes.apple.com/gb/app/yi-dong-cai-bian/id391945719?mt=8"]];
}



@end
