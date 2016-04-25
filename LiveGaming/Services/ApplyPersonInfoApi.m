//
//  ApplyPersonInfoApi.m
//  LiveGaming
//
//  Created by 丁星哲 on 16/4/1.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "ApplyPersonInfoApi.h"
#import "CommonMacro.h"
@implementation ApplyPersonInfoApi{
    NSString *_apply;
}
- (instancetype)initWithApply:(NSString *)apply
{
    self = [super init];
    if (self) {
        _apply = apply;
    }
    return self;
}
-(YTKRequestMethod)requestMethod
{
    return  YTKRequestMethodPost;
}
- (NSString *)requestUrl
{
    return @"/api/Jpush/ApplyGet";
}
- (id)requestArgument
{
    NSDictionary *dict = @{@"Apply":_apply};
    NSString *body = [dict yy_modelToJSONString];
    NSDictionary *bodyDic = @{@"body":body};
    return  bodyDic;
}
@end
