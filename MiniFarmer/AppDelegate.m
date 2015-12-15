//
//  AppDelegate.m
//  MiniFarmer
//
//  Created by huangjiancheng on 15/10/6.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTabBarViewController.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    //[[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    
    RootTabBarViewController *rootVC = [[RootTabBarViewController alloc] initWithNibName:nil bundle:nil];
    self.window.rootViewController = rootVC;
    
    //取出保存的用户信息
    [[MiniAppEngine shareMiniAppEngine] getInfos];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillTerminate) name:UIApplicationWillTerminateNotification object:nil];
   //集成UM分享
    [UMSocialData setAppKey:@"5663c9dee0f55a74a2000b0e"];
    
    //微信
    [UMSocialWechatHandler setWXAppId:@"wxf0cf6ca93505c941" appSecret:@"83c2c6d797f04951c0363aa82d22d6b1" url:@"your app_rederict_uri"];
    //QQ
    [UMSocialQQHandler setQQWithAppId:@"1104804134" appKey:@"oclH9fA1PRv3h0ju" url:@"your app_rederict_uri"];
    
    
    
    return YES;
}
//用于分享回调
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result) {
        //用于调用其他的SDK例如支付宝
    }
    return result;
    

}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)appWillTerminate
{
    //保存用户信息
    [[MiniAppEngine shareMiniAppEngine] saveInfos];
    
}
@end
