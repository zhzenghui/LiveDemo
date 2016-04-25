//
//  Cookie.h
//  M32
//
//  Created by i-Bejoy on 13-12-6.
//  Copyright (c) 2013年 zeng hui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTKKeyValueStore.h"



/**
 * cookie 提供了两种数据保存方式
 * 第一种，将数据保存在NSUserDefault
 * 第二种，将数据保存在sqlite里面，通过使用 YTKKeyValueStore 来实现
 */
@interface Cookie : NSObject

// NSUserDefault 的获取和设置
+ (id)getCookie:(NSString*)keyName;
+ (void)setCookie:(NSString*)keyName value:(id)value;

// sqlite 的获取和设置
+ (id)getKVCookie:(NSString*)keyName;
+ (void)setKVCookie:(NSString*)keyName value:(id)value;


+ (NSArray *)getTableCookie:(NSString*)tableName;
+ (void)removeTableCookie:(NSString *)tableName;

@end