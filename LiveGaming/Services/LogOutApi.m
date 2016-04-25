//
//  LoginOut.m
//  LiveGaming
//
//  Created by 丁星哲 on 16/3/31.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "LogOutApi.h"
#import "Models.h"
@implementation LogOutApi
{
    NSString *_tokenId;
}
-(id)initWithTokenId:(NSString *)tokenId
{
    self = [super init];
    if (self) {
        _tokenId = tokenId;
    }
    return self;
}
- (NSString *)requestUrl
{
    return @"/api/user/Logout";
}
- (id)requestArgument
{
    NSDictionary *dic = @{@"TokenId":_tokenId};
    NSString *body = [dic yy_modelToJSONString];
    NSDictionary *bodyDic = @{@"body":body};
    return bodyDic;
}
- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}
@end
