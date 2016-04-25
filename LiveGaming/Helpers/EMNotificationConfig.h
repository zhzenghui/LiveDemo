//
//  EMNotificationConfig.h
//  LiveGaming
//
//  Created by xy on 16/3/8.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EMNotificationConfig : NSObject



+ (EMNotificationConfig *)shared ;

/**
 *  注册
 *
 *  @param application
 *  @param launchOptions
 */
- (void)registerApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

/**
 *  接收到本地通知
 *
 *  @param notification 通知
 */
-(void)receiveLocalNotification:(UILocalNotification *)notification;

/**
 *  接收到远程推送
 *
 *  @param userInfo
 */
- (void)receiveRemoteNotification:(NSDictionary*)userInfo ;

/**
 *  注册成功apns返回的token
 *
 *  @param deviceToken
 */
-(void)registerForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;


//如果deviceToken获取不到会进入此事件
- (void)didFailToRegisterForRemoteNotificationsWithError:(NSError *)error ;

@end
