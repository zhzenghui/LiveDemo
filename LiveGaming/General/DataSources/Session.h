//
//  Session.h
//  Pet21Show
//
//  Created by zeng on 12-8-13.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import <Foundation/Foundation.h>


/// 程序运行时的全局一些配置信息，程序关闭后将自动消失
/// 如果需要保存请使用 cookie
@interface Session : NSObject

+ (id)getSession:(NSString*)keyName;
+ (void)setSession:(NSString*)keyName value:(id)value;
+ (void)clearSession;

@end
