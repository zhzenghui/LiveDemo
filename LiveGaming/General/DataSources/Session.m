//
//  Session.m
//  Pet21Show
//
//  Created by zeng on 12-8-13.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import "Session.h"
#import "YYMemoryCache.h"


@implementation Session

static YYMemoryCache* sessionDictionary;

+ (void)load {

    @synchronized ([YYMemoryCache class]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sessionDictionary = [[YYMemoryCache alloc] init];
        });
    }
}

+ (id)getSession:(NSString*)keyName {
  if (![keyName isEqualToString:@""] && keyName != nil) {
    return [sessionDictionary objectForKey:keyName];
  }
  return @"";
}

+ (void)setSession:(NSString*)keyName value:(id)value;
{
  [sessionDictionary setObject:value forKey:keyName];
}

+ (void)clearSession {
  if (sessionDictionary) {
    [sessionDictionary removeAllObjects];
  }
}

@end
