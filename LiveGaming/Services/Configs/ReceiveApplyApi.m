
//
//  ReceiveApplyApi.m
//  LiveGaming
//
//  Created by 丁星哲 on 16/4/1.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "ReceiveApplyApi.h"
#import "Models.h"
@implementation ReceiveApplyApi{
    
    NSString *_appliedFor;
    NSString *_apply;
    NSString *_applyMsg;
    NSString *_applyState;
    NSString *_audiencetType;
}
- (instancetype)initWithAppliedFor:(NSString *)applied AudiencetType:(NSString *)audiencetType Apply:(NSString *)apply ApplyMsg:(NSString *)applyMsg ApplyState:(NSString *)applyState
{
    self = [super init];
    if (self) {
        _appliedFor = applied;
        _audiencetType = audiencetType;
        _apply = apply;
        _applyState = applyState;
        _applyMsg  = applyMsg;
    }
    return self;
}
-(YTKRequestMethod)requestMethod
{
    return  YTKRequestMethodPost;
}
- (NSString *)requestUrl
{
    return @"/api/Jpush/ApplyAdd";
}
- (id)requestArgument
{
    NSDictionary *dict = @{@"AppliedFor":_appliedFor,@"AudiencetType":_audiencetType,@"Apply":_apply,@"ApplyMsg":_applyMsg,@"ApplyState":_applyState};
    NSString *body = [dict yy_modelToJSONString];
    NSDictionary *bodyDic = @{@"body":body};
    return  bodyDic;
}
@end
