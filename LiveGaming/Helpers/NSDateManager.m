//
//  NSDateManager.m
//  LiveGaming
//
//  Created by 丁星哲 on 16/3/31.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "NSDateManager.h"

@implementation NSDateManager
static NSDateManager *shareInstance;
+ (id)shareInstance
{
    if (shareInstance == nil) {
        shareInstance = [[NSDateManager alloc]init];
    }
    return shareInstance;
}

// 把字符串转成 YYYY-MM-dd HH:mm:ss 格式
- (NSString *)formatterString:(NSString *)dateStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 先指定时区为GMT标准时间再转换
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
//    2016-03-18T10:44:11
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *currentTime =  [formatter dateFromString:dateStr];
    return [self formatterDate:currentTime];
}
// 把时间转成YYYY-MM-dd HH:mm:ss 字符串
- (NSString *)formatterDate:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *dateStr =  [formatter stringFromDate:date];
    return dateStr;
}

@end
