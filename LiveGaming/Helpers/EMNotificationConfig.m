//
//  EMNotificationConfig.m
//  LiveGaming
//
//  Created by xy on 16/3/8.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "EMNotificationConfig.h"
#import "EaseMob.h"


@implementation EMNotificationConfig

+ (EMNotificationConfig *)shared {
    static EMNotificationConfig *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[EMNotificationConfig alloc] init];
    });
    
    return _sharedManager;
}


- (void)registerApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
}

/**
 *  接收到本地通知
 *
 *  @param notification 通知
 */
-(void)receiveLocalNotification:(UILocalNotification *)notification{
    

}

/**
 *  接收到远程推送
 *
 *  @param userInfo
 */
- (void)receiveRemoteNotification:(NSDictionary*)userInfo {
    //推送反馈(app运行时)

    
}

/**
 *  注册成功apns返回的token
 *
 *  @param deviceToken
 */
-(void)registerForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    //NSString * deviceTokenStr = [XGPush registerDevice:deviceToken];
    UIApplication *application = [UIApplication sharedApplication];
    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];

}


//如果deviceToken获取不到会进入此事件
- (void)didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSString *str = [NSString stringWithFormat: @"Error: %@",err];
    
    NSLog(@"[XGPush Demo]%@",str);
    
    UIApplication *application = [UIApplication sharedApplication];
    
    [[EaseMob sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:err];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"apns.failToRegisterApns", Fail to register apns)
                                                    message:err.description
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
                                          otherButtonTitles:nil];
    [alert show];
}




@end
