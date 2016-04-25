//
//  AppDelegate.m
//  TestTemp
//
//  Created by xy on 16/2/5.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "AppDelegate.h"
#import "NetworkConfig.h"
#import "NotificationConfig.h"
#import "AppDelegate+EaseMob.h"
#import "SocialConfig.h"
#import "Manager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - load default config 

/**
 *  application didFinish Launching
 */
- (void)loadDefaultConfig:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    [NetworkConfig loadYTKDefaultConfig];
    [[NotificationConfig shared] registerNotificationSettings:application didFinishLaunchingWithOptions:launchOptions];
    // 环信
    [self easemobApplication:application didFinishLaunchingWithOptions:launchOptions];

    
    [SocialConfig registerSocial];
    
    
//    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
//    if ([[ver objectAtIndex:0] intValue] >= 7) {
//        // iOS 7.0 or later
//        self.navigationController.navigationBar.barTintColor =  KUIColorFromRGB(0xd8000f);
//        viewController.navigationController.navigationBar.translucent = NO;
//        
//    }else {
//        // iOS 6.1 or earlier
//        viewController.navigationController.navigationBar.tintColor =  KUIColorFromRGB(0xd8000f);
//    }
//    viewController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    
//    //    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor titleColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"FontNAme" size:titleSize], NSFontAttributeName, nil]];
//    
//    //    [[UINavigationBar appearance] setTintColor:[UIColor barColor]];
    
    // Navigation bar buttons appearance
//    CGFloat titleSize = 17;
//    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, shadowColor, NSShadowAttributeName, [UIFont fontWithName:@"FontName" size:titleSize], NSFontAttributeName, nil]];
    //    viewController.navigationController.navigationBar.backgroundColor = KUIColorFromRGB(0xd8000f);// [color colorWithAlphaComponent:alpha];

}

- (void)openLogin {
    
}

#pragma mark - application

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self loadDefaultConfig:application didFinishLaunchingWithOptions:launchOptions];
 

//    测试代码----------------------------------------
    [XGPush setAccount:@"t"];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    
//    NSArray *allLanguage = [defaults objectForKey:@"AppleLanguages"];
//    NSString *currentLanguage = [allLanguage objectAtIndex:0];
//    NSLog(@"The current language is : %@", currentLanguage);

//    NSString *s= [NSString stringWithFormat:NSLocalizedString(@"register", nil)];
//    NSLog(@"NSLocalizedString: %@", s);
////    -----------------------------------------------
//#if UUserZeng
////    HostViewController *hvc = [[HostViewController alloc] init];
////
////    self.window.rootViewController = hvc;
////    [self.window makeKeyAndVisible];
//#endif
    
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    NSLog(@"%@", token);
    
    [[NotificationConfig shared] registerForRemoteNotificationsWithDeviceToken:deviceToken];

}



- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [[NotificationConfig shared] failToRegist:application error:error];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [[NotificationConfig shared] receiveRemoteNotification:userInfo];
}

- (void)applicationWillResignActive:(UIApplication *)application {

    //进入后台执行
}

- (void)applicationDidEnterBackground:(UIApplication *)application {

    // 进入后台执行，在 resignactive 之后
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

    // 后台进入前台执行
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    // 首次启动执行
    // 后台进入前台执行，在willenter之后执行
    
    
#ifdef UUser

#endif
    
    
#ifdef UUserZeng

    
#endif
    
    
    if ([Manager sharedManager].loginUser.MobilePhone) {
        
    }
    else {
        [self openLogin];
    }

    [UMSocialSnsService  applicationDidBecomeActive];

    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}



- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return YES;
}



#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_

//注册UserNotification成功的回调
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //用户已经允许接收以下类型的推送
    UIUserNotificationType allowedTypes = [notificationSettings types];
    
    NSLog(@"%lu", (unsigned long)allowedTypes);
}

//按钮点击事件回调
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler{
    if([identifier isEqualToString:@"ACCEPT_IDENTIFIER"]){
        NSLog(@"ACCEPT_IDENTIFIER is clicked");
    }
    
    completionHandler();
}

#endif

@end
