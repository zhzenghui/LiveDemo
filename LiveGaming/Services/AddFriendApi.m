


//
//  AddFriendApi.m
//  LiveGaming
//
//  Created by 丁星哲 on 16/4/1.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "AddFriendApi.h"
#import "CommonMacro.h"
@implementation AddFriendApi{
    NSString *_apply;
    NSString *_appliedFor;
    NSString *_applyMsg;
    NSString *_audienceYype;
    
}
- (instancetype)initWithApply:(NSString *)apply AppliedFor:(NSString *)appliedFor ApplyMsg:(NSString *)applyMsg AudiencetYype:(NSString *)audiencetYype
{
    self = [super init];
    if (self) {
        _apply = apply;
        _applyMsg = applyMsg;
        _appliedFor = appliedFor;
        _audienceYype = audiencetYype;
    }
    return self;
}
- (id)requestArgument
{
    NSDictionary *dict = @{@"Apply":_apply,@"AppliedFor":_appliedFor,@"ApplyMsg":_applyMsg,@"AudiencetYype":_audienceYype};
    NSString *body = [dict yy_modelToJSONString];
    NSDictionary *bodyDic = @{@"body":body};
    return bodyDic;
}
- (YTKRequestMethod)requestMethod{
    return  YTKRequestMethodPost;
}
- (NSString *)requestUrl{
    return @"/api/Jpush/ApplyFriendsAdd";
}



@end
