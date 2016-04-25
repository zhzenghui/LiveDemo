//
//  EditUserInfoApi.h
//  LiveGaming
//
//  Created by 丁星哲 on 16/3/26.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import <YTKRequest.h>
@interface EditUserInfoApi : YTKRequest
- (id)initWithAge:(NSString *)age  UserID:(NSString *)userId sex:(NSString *)sex UserName:(NSString *)userName Introduce:(NSString *)introduce;
@end
