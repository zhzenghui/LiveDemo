//
//  ApplyPersonInfoApi.h
//  LiveGaming
//
//  Created by 丁星哲 on 16/4/1.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import <YTKRequest.h>

@interface ApplyPersonInfoApi : YTKRequest
// 申请者个人信息
- (instancetype)initWithApply:(NSString *)apply;
@end
