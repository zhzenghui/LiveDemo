//
//  NSDateManager.h
//  LiveGaming
//
//  Created by 丁星哲 on 16/3/31.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateManager : NSObject
+ (id)shareInstance;
- (NSString *)formatterString:(NSString *)dateStr;
- (NSString *)formatterDate:(NSDate *)date;
@end
