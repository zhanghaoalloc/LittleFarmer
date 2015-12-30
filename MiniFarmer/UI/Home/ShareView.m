//
//  ShareView.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/29.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "ShareView.h"
#import "UIView+UIViewController.h"
#import "UserInfo.h"
#import "LoginViewController.h"
#import "HomeViewController.h"
#import "RootTabBarViewController.h"
#import "UMSocial.h"

@implementation ShareView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;

}
- (void)awakeFromNib{
    [_back setImage:[UIImage imageNamed:@"home_study_back_btn"] forState:UIControlStateNormal];
    [_back addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];

    
    [_gohome setImage:[UIImage imageNamed:@"home_study_gohome_btn"] forState:UIControlStateNormal];
    
    [_gohome addTarget:self action:@selector(gohome:) forControlEvents:UIControlEventTouchUpInside];
    
    [_collection setImage:[UIImage imageNamed:@"home_study_collection_nm"] forState:UIControlStateNormal];
    [_collection setImage:[UIImage imageNamed:@"home_study_collection_select"] forState:UIControlStateSelected];
    _collection.backgroundColor = [UIColor clearColor];
    [_collection addTarget:self action:@selector(collectionAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_share setImage:[UIImage imageNamed:@"home_study_share_btn"] forState:UIControlStateNormal];
    [_share addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)backAction:(UIButton *)button{
  
    [self.ViewController.navigationController popViewControllerAnimated:YES];
    
}
- (void)gohome:(UIButton *)button{
    [self.ViewController.navigationController popToRootViewControllerAnimated:YES];

}
- (void)collectionAction:(UIButton *)button{
   // button.selected = !button.selected;
    NSString *userid = [UserInfo shareUserInfo].userId
    ;
    if (userid == nil) {
        button.selected = NO;
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        
        [self.ViewController presentViewController:loginVC animated:YES completion:nil];
        loginVC.loginBackBlock = ^{
            
        };
        }else {
        if (button.selected == YES) {//已收藏 取消收藏
            [self _requestData:@"?c=wxjs&m=cancel_xjs_collection" type:NO];
        }else{//取没有收藏，要收藏
            [self _requestData:@"?c=wxjs&m=add_xjs_collection" type:YES];
        }
        
    }

}
- (void)shareAction:(UIButton *)button{
    

    NSString *imageName = [kPictureURL stringByAppendingString:_model.zp1];

    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:imageName];
    NSString *title = _model.fbwh;
    
    [UMSocialData defaultData].extConfig.qqData.title=title;
    [UMSocialData defaultData].extConfig.qzoneData.title=title;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title=title;
    [UMSocialData defaultData].extConfig.wechatSessionData.title=title;
    
    NSString *content = _model.title;
    

    //设置分享的内容
    [UMSocialData defaultData].extConfig.wechatSessionData.shareText = content;
    [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = content;
    [UMSocialData defaultData].extConfig.qqData.shareText = content;
    [UMSocialData defaultData].extConfig.qzoneData.shareText = content;
    
    NSString *contentURL =[NSString stringWithFormat:@"%@?%@",KshareURl,_model.bachid];
    
    //设置分享后的跳转
    [UMSocialData defaultData].extConfig.qzoneData.url = contentURL;
    [UMSocialData defaultData].extConfig.qqData.url =contentURL;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = contentURL;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = contentURL;
    
    
    [UMSocialSnsService presentSnsIconSheetView:self.ViewController
                                         appKey:@"5663c9dee0f55a74a2000b0e"
                                      shareText:@""
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone]
                                       delegate:self];
}

//实现回调方法（可选）：
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}



#pragma mark---收藏和取消技术
- (void)_requestData:(NSString *)url type:(BOOL)isclloection {
    NSString *userid = [UserInfo shareUserInfo].userId;

    
    NSDictionary *dic = @{
                          @"userid":userid,
                          @"xjsid":_model.bachid
                              };
    __weak ShareView *weself = self;
    
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestGet subUrl:url parameters:dic prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *msg = responseObject[@"msg"];
        if ([msg isEqualToString:@"success"]) {
            if (isclloection == YES) {
                _collection.selected = !_collection.selected;
                [weself.ViewController.view showWeakPromptViewWithMessage:@"收藏成功"];
               
            }else{
                _collection.selected = !_collection.selected;
                [weself.ViewController.view showWeakPromptViewWithMessage:@"取消收藏"];
                
            }
            
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (isclloection == YES) {
            [weself.ViewController.view showWeakPromptViewWithMessage:@"收藏失败"];
            
        }else{
            [weself.ViewController.view showWeakPromptViewWithMessage:@"取消收藏失败"];
            
        }
    
    }];
    
}
- (void)setIscoll:(NSNumber *)iscoll{
    _iscoll = iscoll;
    if ([iscoll integerValue]!= 0) {
        _collection.selected = YES;
    }
    
}
- (void)setModel:(DieaseModel *)model{

    _model = model;
    
}



@end
