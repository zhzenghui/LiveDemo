//
//  LoginApi.m
//  LiveGaming
//
//  Created by xy on 16/3/10.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "GetGuessListApi.h"

@implementation GetGuessListApi{
    NSString *_body;

}

- (id)initWithBody:(NSString *)body {
    self = [super init];
    if (self) {
        _body = body;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/api/guess/GetGuessList";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"body": _body
             };
}
- (id)jsonValidator {
    return @{
             @"StateCode": [NSNumber class]
             };
}



@end
