//
//  JPNotificationConfig.m
//  LiveGaming
//
//  Created by xy on 16/3/25.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "JPNotificationConfig.h"
#import "JPUSHService.h"


static NSString *appKey = @"48ccf39019f9999adfbf9bad";
static NSString *channel = @"test channel";
static BOOL isProduction = FALSE;


@implementation JPNotificationConfig



+ (JPNotificationConfig *)shared {
    static JPNotificationConfig *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[JPNotificationConfig alloc] init];
    });
    
    return _sharedManager;
}

/**
 *  注册
 *
 *  @param application
 *  @param launchOptions
 */
- (void)registerApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel apsForProduction:isProduction];
}

/**
 *  接收到本地通知
 *
 *  @param notification 通知
 */
-(void)receiveLocalNotification:(UILocalNotification *)notification {

}

/**
 *  接收到远程推送
 *
 *  @param userInfo
 */
- (void)receiveRemoteNotification:(NSDictionary*)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"收到通知:%@", [self logDic:userInfo]);
}

/**
 *  注册成功apns返回的token
 *
 *  @param deviceToken
 */
-(void)registerForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
}


//如果deviceToken获取不到会进入此事件
- (void)didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
}



- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

@end
