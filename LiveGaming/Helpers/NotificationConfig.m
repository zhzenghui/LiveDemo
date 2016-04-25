//
//  NotificationConfig.m
//  LiveGaming
//
//  Created by xy on 16/2/29.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "NotificationConfig.h"


@implementation NotificationConfig


+ (NotificationConfig *)shared {
    static NotificationConfig *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[NotificationConfig alloc] init];
    });
    
    return _sharedManager;
}

- (void)registerNotificationSettings:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    
#if (TARGET_IPHONE_SIMULATOR)
    // 在模拟器的情况下
#else
    // 在真机情况下
//    [[XGNotificationConfig shared] registerApplication:application didFinishLaunchingWithOptions:launchOptions];
    [[JPNotificationConfig shared] registerApplication:application didFinishLaunchingWithOptions:launchOptions];
#endif


}

- (void)failToRegist:(UIApplication *)application error:(NSError *)err {
//    [[XGNotificationConfig shared] didFailToRegisterForRemoteNotificationsWithError:err];
//    [[EMNotificationConfig shared] didFailToRegisterForRemoteNotificationsWithError:err];
    [[JPNotificationConfig shared] didFailToRegisterForRemoteNotificationsWithError:err];
}


- (void)unregisterForRemoteNotifications:(UIApplication *)application {
    
    [application unregisterForRemoteNotifications];
    [XGPush unRegisterDevice];
    
}


- (void)registerForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
    
//    [[XGNotificationConfig shared] registerForRemoteNotificationsWithDeviceToken:devToken];
//    [[EMNotificationConfig shared] registerForRemoteNotificationsWithDeviceToken:devToken];
    [[JPNotificationConfig shared] registerForRemoteNotificationsWithDeviceToken:devToken];
}


- (void )receiveRemoteNotification:(NSDictionary *)userInfo {
    
//    [[XGNotificationConfig shared] receiveRemoteNotification:userInfo];
//    [[EMNotificationConfig shared] receiveRemoteNotification:userInfo];
    [[JPNotificationConfig shared] receiveRemoteNotification:userInfo];
}


- (void)receiveLocalNotification:(UILocalNotification *)notification {
    
//    [[XGNotificationConfig shared] receiveLocalNotification:notification];
//    [[EMNotificationConfig shared] receiveLocalNotification:notification];
    [[JPNotificationConfig shared] receiveLocalNotification:notification];
    
}


@end
