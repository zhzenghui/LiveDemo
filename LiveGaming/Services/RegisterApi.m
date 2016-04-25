//
//  RegisterApi.m
//  Solar
//
//  Created by TangQiao on 11/8/14.
//  Copyright (c) 2014 fenbi. All rights reserved.
//

#import "RegisterApi.h"
#import "YYModel.h"

@implementation RegisterApi {
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
    return @"/api/user/Register";
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
//        @"nick": [NSString class],
//        @"level": [NSNumber class]
    };
}

- (NSString *)userId {
    return [[[self responseJSONObject] objectForKey:@"userId"] stringValue];
}

@end
