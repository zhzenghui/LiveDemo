//
//  Cookie.m
//  M32
//
//  Created by i-Bejoy on 13-12-6.
//  Copyright (c) 2013年 zeng hui. All rights reserved.
//

#import "Cookie.h"
#import "DEFINE.h"
#import "CCLog.h"



static YTKKeyValueStore *store;

#define KCookieTableName @"cookie_table"

@implementation Cookie

#define KNSUserDefaults [NSUserDefaults standardUserDefaults]



+ (void)load{
    store = [[YTKKeyValueStore alloc] initDBWithName:@"data.db"];
    // 创建名为user_table的表，如果已存在，则忽略该操作
    [store createTableWithName:KCookieTableName];

}





+ (id)getCookie:(NSString*)keyName {
  if (![keyName isEqualToString:@""] && keyName != nil) {
    id dict = [KNSUserDefaults objectForKey:keyName];

    if (!dict) {
      return nil;
    }
    return dict;
  }

  return nil;
}

+ (void)setCookie:(NSString*)keyName value:(id)value;
{
  [KNSUserDefaults setObject:value forKey:keyName];

  [KNSUserDefaults synchronize];

}


+ (NSString *)getKVCookie:(NSString*)keyName {
    if (![keyName isEqualToString:@""] && keyName != nil) {
        NSString *str = [store getStringById:keyName fromTable:KCookieTableName];
        if (!str) {
            return nil;
        }
        return str;
    }
    
    return nil;
}

+ (void)setKVCookie:(NSString*)keyName value:(NSString *)value;
{
    [store putString:value withId:keyName intoTable:KCookieTableName];
}




+ (NSArray *)getTableCookie:(NSString*)tableName {
    if (![tableName isEqualToString:@""] && tableName != nil) {
        NSArray *array = [store getAllItemsFromTable:tableName];
        if (!array) {
            return nil;
        }
        return array;
    }
    
    return nil;

}

+ (void)removeTableCookie:(NSString *)tableName {
    
    if (![tableName isEqualToString:@""] && tableName != nil) {
        
        [store clearTable:tableName];
    }
    
}




@end
