//
//  ZYTokenManager.h
//  自定义搜索框并缓存搜索记录
//
//  Created by xiayong on 16/3/11.
//  Copyright © 2016年 bianguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ZYTokenManager : NSObject
//缓存搜索的数组
+(void)SearchText :(NSString *)seaTxt;
//清除缓存数组
+(void)removeAllArray;
//计算label的宽度
+ (CGFloat)contentHeight:(NSString *)content;
// 计算label的高度
+ (CGFloat)contentWight:(NSString *)content;
@end
