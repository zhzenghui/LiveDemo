//
//  LoginApi.m
//  LiveGaming
//
//  Created by xy on 16/3/10.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "LoginApi.h"
#import "YYModel.h"

@implementation LoginApi{
    NSString *_username;
    NSString *_password;
}

- (id)initWithUsername:(NSString *)username password:(NSString *)password {
    self = [super init];
    if (self) {
        _username = username;
        _password = password;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/api/user/login";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    
    NSDictionary *dict = @{
                           @"LoginName": _username,
                           @"PassWord": _password
                           };
    NSString *s = [dict yy_modelToJSONString];
    NSDictionary *dc = @{@"body": s};
    return dc;
}

- (id)jsonValidator {
    return @{
             @"StateCode": [NSNumber class],
//             @"loginUser": [NSDictionary class],
//             @"Message": [NSString class]
             };
}

- (NSString *)userId {
    return [[[self responseJSONObject] objectForKey:@"userId"] stringValue];
}


@end
