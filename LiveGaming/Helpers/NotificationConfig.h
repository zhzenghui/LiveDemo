//
//  NotificationConfig.h
//  LiveGaming
//
//  Created by xy on 16/2/29.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "AppDelegate.h"
#import "XGNotificationConfig.h"
#import "EMNotificationConfig.h"
#import "JPNotificationConfig.h"


/**
 *  远程通知配置类
 */
@interface NotificationConfig : NSObject


+ (NotificationConfig *)shared ;

/**
 *  注册远程通知信息
 *
 *  @param application app
 */
- (void)registerNotificationSettings:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

/**
 *  注册远程通知失败时，回调
 *
 *  @param application app
 *  @param err         错误
 */
- (void)failToRegist:(UIApplication *)application error:(NSError *)err ;

/**
 *  取消远程通知消息
 *
 *  @param application app
 */
- (void)unregisterForRemoteNotifications:(UIApplication *)application ;

/**
 *  注册远程通知成功时， 返回到devtoken
 *
 *  @param devToken token
 */
- (void)registerForRemoteNotificationsWithDeviceToken:(NSData *)devToken ;


/**
 *  接受到通知
 *
 *  @param userInfo 回调的数据
 */
- (void)receiveRemoteNotification:(NSDictionary *)userInfo;


- (void)receiveLocalNotification:(UILocalNotification *)notification;




@end
