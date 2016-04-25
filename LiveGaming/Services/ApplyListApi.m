//
//  ApplyListApi.m
//  LiveGaming
//
//  Created by 丁星哲 on 16/4/1.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "ApplyListApi.h"
#import "Models.h"
@implementation ApplyListApi{
    NSString *_appliedFor;
    NSString *_audiencetType;
    NSString *_CurrentPage;
}
- (instancetype)initWithAppliedFor:(NSString *)applied AudiencetType:(NSString *)audiencetType CurrentPage:(NSString *)currentPage
{
    self = [super init];
    if (self) {
        _appliedFor = applied;
        _audiencetType = audiencetType;
        _CurrentPage = currentPage;
    }
    return self;
}
-(YTKRequestMethod)requestMethod
{
    return  YTKRequestMethodPost;
}
- (NSString *)requestUrl
{
    return @"/api/Jpush/ApplyList";
}
- (id)requestArgument
{
    NSDictionary *dict = @{@"AppliedFor":_appliedFor,@"AudiencetType":_audiencetType,@"CurrentPage":_CurrentPage};
    NSString *body = [dict yy_modelToJSONString];
    NSDictionary *bodyDic = @{@"body":body};
    return  bodyDic;
}

@end
