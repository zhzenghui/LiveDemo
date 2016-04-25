//
//  ApplyListApi.h
//  LiveGaming
//
//  Created by 丁星哲 on 16/4/1.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import <YTKRequest.h>

@interface ApplyListApi : YTKRequest
-(instancetype)initWithAppliedFor:(NSString *)applied AudiencetType:(NSString *)audiencetType CurrentPage:(NSString *)currentPage;
@end
